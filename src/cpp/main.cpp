#include <core/logger.h>

#include <iostream>
#include <string>
#include <vector>

#include "spdlog/sinks/stdout_color_sinks.h"
#include "spdlog/spdlog.h"

int main() {
  auto logger = spdlog::stdout_color_mt("console");
  spdlog::set_default_logger(logger);

  core::Logger app("DemoApp");
  std::vector<int> numbers = {1, 2, 3, 4, 5};

  core::logi("test: {}", 5);

  app.process_data(numbers);

  return 0;
}
