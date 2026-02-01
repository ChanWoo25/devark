// Authors:
//   - Chanwoo Lee <leechanwoo25@outlook.com>
//
#include <core/logger.h>

#include <filesystem>
#include <iostream>

namespace core {

void Logger::Init(const std::string& log_file_path,
                  const std::map<std::string, int>& initial_vlevels) {
  std::lock_guard<std::mutex> lock(mutex_);

  // 1) Store initial configuration.
  config_levels_ = initial_vlevels;

  // 2) Configure spdlog (console + file).
  try {
    auto console_sink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
    auto file_sink = std::make_shared<spdlog::sinks::basic_file_sink_mt>(
        log_file_path, true);  // true = truncate

    std::vector<spdlog::sink_ptr> sinks{console_sink, file_sink};

    logger_ = std::make_shared<spdlog::logger>("multi_sink", sinks.begin(),
                                               sinks.end());
    logger_->set_level(spdlog::level::debug);  // Always enable spdlog.
    logger_->flush_on(spdlog::level::debug);

    spdlog::register_logger(logger_);
  } catch (const spdlog::spdlog_ex& ex) {
    std::cerr << "Log init failed: " << ex.what() << std::endl;
  }
}

std::atomic<int>* Logger::GetFileVLevelPtr(const std::string& full_file_path) {
  std::lock_guard<std::mutex> lock(mutex_);

  // Return existing pointer if already registered.
  auto found = active_file_levels_.find(full_file_path);
  if (found != active_file_levels_.end()) {
    return found->second.get();
  }

  // Otherwise, search initial config for a match.
  int initial_level = 0;  // Default to 0.
  for (const auto& [name_key, level_val] : config_levels_) {
    if (EndsWith(full_file_path, name_key)) {
      initial_level = level_val;
      break;  // Assumes no duplicate names.
    }
  }

  // Create and store the pointer.
  auto inserted = active_file_levels_.emplace(
      full_file_path, std::make_unique<std::atomic<int>>(initial_level));
  return inserted.first->second.get();
}

void Logger::SetLevel(const std::string& file_name, int level) {
  std::lock_guard<std::mutex> lock(mutex_);

  // 1) Update config map for future files.
  config_levels_[file_name] = level;

  // 2) Update already-active files that match.
  for (auto& [full_path, atomic_lvl] : active_file_levels_) {
    if (EndsWith(full_path, file_name)) {
      atomic_lvl->store(level, std::memory_order_relaxed);
      // Update all files whose full path matches the file_name.
    }
  }
}

bool Logger::EndsWith(const std::string& full_path, const std::string& ending) {
  if (ending.empty()) {
    return false;
  }

  if (full_path.size() >= ending.size() &&
      std::equal(ending.rbegin(), ending.rend(), full_path.rbegin())) {
    return true;
  }

  std::string stem = std::filesystem::path(full_path).stem().string();
  return stem == ending;
}

void Logger::process_data(const std::vector<int>& data) {
  vlog(1, "Processing data of size: {}", data.size());
  for (const auto& num : data) {
    vlog(2, "Number: {}", num);
  }
  logi("Data processing completed.");
}

}  // namespace core
