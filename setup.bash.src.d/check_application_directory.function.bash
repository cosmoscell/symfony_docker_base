# @todo

echo -e "${ANSI_BOLD}${ANSI_FG_YELLOW}Checking app/ directory (""${APP_DIR_HOST}"") ...${ANSI_DEFAULT}"
if [ ! -d ${APP_DIR_HOST} ]; then
  mkdir -p ${APP_DIR_HOST} && \
    chmod 777 ${APP_DIR_HOST} && \
    echo -e -n "${ANSI_OK}"' ' && \
    echo 'app/ directory ('"${APP_DIR_HOST}"') created' && \
    echo ''
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'app/ directory ('"${APP_DIR_HOST}"') exists'
    echo ''
fi
