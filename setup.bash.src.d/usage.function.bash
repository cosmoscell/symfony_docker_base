usage() {
  if [ "${#}" -ne '1' -o "${1}" != 'dev' -a "${1}" != 'prod' ]; then
    echo -n '   '
    echo -e "${ANSI_BOLD}${ANSI_FG_YELLOW}Usage:${ANSI_DEFAULT}"
    echo ''
    echo -n '      '
    echo -e "${ANSI_BOLD}${0}${ANSI_DEFAULT}"' ''dev|prod'
    echo '';
    exit 0
  fi
  return 0
}
