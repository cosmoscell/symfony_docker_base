# @todo

mkdir -p ${UPLOADS_DIR_HOST} && \
  chmod 777 ${UPLOADS_DIR_HOST} && \
  echo -e -n "${ANSI_OK}"' ' && \
  echo -e -n "\e[1;97;42m OK \e[0m"' ' && \
  echo 'uploads/ directory ('"${UPLOADS_DIR_HOST}"') created' && \
  echo ''
