cmake_minimum_required(VERSION 3.10)
project(devark_project)

# 1. spdlog 빌드 옵션 설정 (정적 라이브러리로 빌드)
set(SPDLOG_BUILD_COMPILED ON CACHE BOOL "" FORCE)

# 2. 서브모듈 디렉토리 추가
# 경로: src/cpp/external/spdlog
add_subdirectory(src/cpp/external/spdlog)

# 3. 내 실행 파일 또는 라이브러리 타겟 생성
add_executable(${PROJECT_NAME} src/cpp/main.cpp)

# 4. 타겟에 spdlog 연결 (정적 라이브러리 형태인 spdlog::spdlog 연결)
target_link_libraries(${PROJECT_NAME} PRIVATE spdlog::spdlog)

# 5. 소스코드에서 정적 라이브러리 모드를 인식하도록 매크로 정의 (권장)
target_compile_definitions(${PROJECT_NAME} PRIVATE SPDLOG_COMPILED_LIB)