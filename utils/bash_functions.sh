#!/bin/bash

# === ANSI Color Codes & Bold ===
RED="\033[0;31m"    # normal
RED_BR="\033[1;31m" # bright
RED_LT="\033[91m"   # light
GRN="\033[0;32m"
GRN_BR="\033[1;32m"
GRN_LT="\033[92m"
BLU="\033[0;34m"
BLU_BR="\033[1;34m"
BLU_LT="\033[94m"
YLW="\033[1;33m"
BOLD="\033[1m"
RESET="\033[0m"

TestColorCodes() {
  echo -e "${RED}Test text to test color code${RESET}"
  echo -e "${RED_BR}Test text to test color code${RESET}"
  echo -e "${RED_LT}Test text to test color code${RESET}"
  echo -e "${GRN}Test text to test color code${RESET}"
  echo -e "${GRN_BR}Test text to test color code${RESET}"
  echo -e "${GRN_LT}Test text to test color code${RESET}"
  echo -e "${BLU}Test text to test color code${RESET}"
  echo -e "${BLU_BR}Test text to test color code${RESET}"
  echo -e "${BLU_LT}Test text to test color code${RESET}"
  echo -e "${YLW}Test text to test color code${RESET}"
  echo -e "${BOLD}Test text to test color code${RESET}"
}

# === Print Functions ===
PrintDebug() {
  echo -e "[${BLU_LT}DBUG${RESET}] $1"
}

PrintInfo() {
  echo -e "[${BOLD}${GRN}INFO${RESET}] $1"
}

PrintWarn() {
  echo -e "[${BOLD}${YLW}WARN${RESET}] $1"
}

PrintErr() {
  echo -e "[${BOLD}${RED}ERRO${RESET}] $1"
}