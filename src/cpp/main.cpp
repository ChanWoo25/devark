#include <iostream>
#include <string>
#include <vector>

#include "spdlog/sinks/stdout_color_sinks.h"
#include "spdlog/spdlog.h"

namespace MyProject {

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
}  // namespace MyProject

int main() {
  auto logger = spdlog::stdout_color_mt("console");
  spdlog::set_default_logger(logger);

  MyProject::Logger app("DemoApp");
  std::vector<int> numbers = {1, 2, 3, 4, 5};

  app.process_data(numbers);

  return 0;
}
