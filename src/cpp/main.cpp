// Authors:
//   - Chanwoo Lee <leechanwoo25@outlook.com>
//
#include <core/logger.h>

#include <string>
#include <vector>

int main() {
  std::map<std::string, int> vlevel_config;
  vlevel_config["logger"] = 2;
  vlevel_config["main"] = 1;
  core::Logger::Instance().Init("log.txt", vlevel_config);
  logi("Server Started");

  std::vector<int> numbers = {1, 2, 3, 4, 5};
  core::Logger::Instance().process_data(numbers);

  return 0;
}
