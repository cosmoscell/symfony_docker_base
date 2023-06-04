
# @todo

echo -e "${ANSI_BOLD}${ANSI_FG_YELLOW}${COMPOSE_OVERRIDE_FILE} ...${ANSI_DEFAULT}"
if [ "${ENVIRONMENT}" = 'PROD' ]; then
  if [ -f ${COMPOSE_OVERRIDE_FILE} ]; then
    echo 'Removing'' '"${COMPOSE_OVERRIDE_FILE}"
    rm ${COMPOSE_OVERRIDE_FILE} && \
      echo -e -n "${ANSI_OK}"' ' && \
      echo "${COMPOSE_OVERRIDE_FILE}"' ''removed' && \
      echo ''
  else
    echo -e -n "${ANSI_OK}"' '
    echo "${COMPOSE_OVERRIDE_FILE}"' ''does not exist'
    echo ''
  fi
else
  if [ -f ${COMPOSE_OVERRIDE_FILE} ]; then
    echo 'Overwriting'' '"${COMPOSE_OVERRIDE_FILE}"' ''with'' '"${COMPOSE_OVERRIDE_DIST_FILE}"
    cp ${COMPOSE_OVERRIDE_DIST_FILE} ${COMPOSE_OVERRIDE_FILE} && \
      echo -e -n "${ANSI_OK}"' ' && \
      echo "${COMPOSE_OVERRIDE_FILE}"' ''overwritten' && \
      echo ''
  else
    echo 'Creating'' '"${COMPOSE_OVERRIDE_FILE}"' ''from'' '"${COMPOSE_OVERRIDE_DIST_FILE}"
    cp ${COMPOSE_OVERRIDE_DIST_FILE} ${COMPOSE_OVERRIDE_FILE} && \
      echo -e -n "${ANSI_OK}"' ' && \
      echo "${COMPOSE_OVERRIDE_FILE}"' ''created' && \
      echo ''
  fi
fi
