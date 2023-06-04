# @todo

echo -e "${ANSI_BOLD}${ANSI_FG_YELLOW}Starting Docker services ...${ANSI_DEFAULT}"
docker compose up -d --remove-orphans && \
  echo -e -n "${ANSI_OK}"' ' && \
  echo 'Containers running' && \
  echo ''
