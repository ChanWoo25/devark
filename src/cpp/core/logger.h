#ifndef CORE_LOGGER_H
#define CORE_LOGGER_H

#include <string>
#include <utility>

#include "spdlog/spdlog.h"

namespace core {

template <typename... Args>
void logi(const std::string& strfmt, Args&&... args) {
  spdlog::info(strfmt, std::forward<Args>(args)...);
}

class Logger {
 public:
  Logger(std::string name) : name_(std::move(name)) {}

  void process_data(const std::vector<int>& data) {
    // 긴 조건문과 정렬 확인용
    if (data.empty() || data.size() > 1000) {
      spdlog::error("Invalid data size: {}", data.size());
      return;
    }

    for (const auto& item : data) {
      // 복잡한 연산자 정렬 및 들여쓰기 확인
      int result = (item * 10) + (item / 2) - 5;
      spdlog::info("Processing: {} -> {}", item, result);
    }
  }

 private:
  std::string name_;
  int retry_count = 0;
  bool is_active = true;  // AlignConsecutiveAssignments 확인용
};

}  // namespace core

#endif