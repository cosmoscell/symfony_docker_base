intro() {
  echo -e ""
  echo -e "${ANSI_BG_BLUE}""$(printf '%*s' 66)""${ANSI_BG_DEFAULT}"
  echo -e "${ANSI_BG_BLUE}""$(printf '%*s' 3)""${ANSI_BOLD}${ANSI_FG_GREEN}${APP_NAME}${ANSI_FG_DEFAULT} version ${ANSI_FG_YELLOW}${APP_VERSION}${ANSI_FG_DEFAULT}${ANSI_BOLD_OFF}""$(printf '%*s' 19)""${ANSI_BG_DEFAULT}"
  echo -e "${ANSI_BG_BLUE}""$(printf '%*s' 3)""(c) $(date +%Y) ${AUTHOR_NAME} <${AUTHOR_EMAIL}>""$(printf '%*s' 3)""${ANSI_BG_DEFAULT}"
  echo -e "${ANSI_BG_BLUE}""$(printf '%*s' 66)""${ANSI_BG_DEFAULT}"
  echo -e "${ANSI_DEFAULT}"
  return 0
}
