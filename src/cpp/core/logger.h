// Authors:
//   - Chanwoo Lee <leechanwoo25@outlook.com>
//
#ifndef CORE_LOGGER_H
#define CORE_LOGGER_H

#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/spdlog.h>

#include <atomic>
#include <map>
#include <memory>
#include <mutex>
#include <string>
#include <unordered_map>
#include <vector>

namespace core {

class Logger {
 public:
  // Returns the singleton logger instance.
  static Logger& Instance() {
    static Logger instance;
    return instance;
  }

  // Initializes sinks and per-file verbosity defaults.
  void Init(const std::string& log_file_path,
            const std::map<std::string, int>& initial_vlevels);

  // Returns the internal spdlog logger (may be null before Init).
  std::shared_ptr<spdlog::logger> GetSpdLogger() { return logger_; }

  // Returns a pointer to the per-file verbosity level for a full path.
  std::atomic<int>* GetFileVLevelPtr(const std::string& full_file_path);

  // Updates verbosity level for any file matching the given name.
  void SetLevel(const std::string& file_name, int level);

  // Example helper that logs processing progress for provided data.
  void process_data(const std::vector<int>& data);

 private:
  Logger() = default;
  ~Logger() = default;
  Logger(const Logger&) = delete;
  Logger& operator=(const Logger&) = delete;

  // Returns true if full_path matches a suffix or stem name.
  bool EndsWith(const std::string& full_path, const std::string& ending);

  std::shared_ptr<spdlog::logger> logger_;

  // Tracks active files (called by macros) and their level pointers.
  // Key: __FILE__ (full path), Value: atomic level
  std::unordered_map<std::string, std::unique_ptr<std::atomic<int>>>
      active_file_levels_;

  // Stores initial levels for files that have not been seen yet.
  // Key: short filename (e.g., "logger.cc"), Value: level
  std::map<std::string, int> config_levels_;

  std::mutex mutex_;
};

}  // namespace core

#define vlog(level, ...)                                           \
  do {                                                             \
    static std::atomic<int>* _local_vlevel =                       \
        core::Logger::Instance().GetFileVLevelPtr(__FILE__);       \
    if (level <= _local_vlevel->load(std::memory_order_relaxed)) { \
      auto _logger = core::Logger::Instance().GetSpdLogger();      \
      if (_logger) {                                               \
        _logger->debug(__VA_ARGS__);                               \
      }                                                            \
    }                                                              \
  } while (0)
#define logi(...)                                           \
  do {                                                      \
    auto _logger = core::Logger::Instance().GetSpdLogger(); \
    if (_logger) {                                          \
      _logger->info(__VA_ARGS__);                           \
    }                                                       \
  } while (0)
#define logw(...)                                           \
  do {                                                      \
    auto _logger = core::Logger::Instance().GetSpdLogger(); \
    if (_logger) {                                          \
      _logger->warn(__VA_ARGS__);                           \
    }                                                       \
  } while (0)
#define loge(...)                                           \
  do {                                                      \
    auto _logger = core::Logger::Instance().GetSpdLogger(); \
    if (_logger) {                                          \
      _logger->error(__VA_ARGS__);                          \
    }                                                       \
  } while (0)

#endif
