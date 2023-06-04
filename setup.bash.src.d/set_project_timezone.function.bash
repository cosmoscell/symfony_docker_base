set_project_timezone() {
  echo_section 'Project time zone'
  read -p 'Project time zone (default: "'"${PROJECT_TIMEZONE_DEFAULT}"'"):'' ' PROJECT_TIMEZONE
  PROJECT_TIMEZONE=$(clean "${PROJECT_TIMEZONE}@" 'a-zA-Z0-9/_-' ${PROJECT_TIMEZONE_MAX_LENGTH})
  if [ "${PROJECT_TIMEZONE}" = '' ]; then
    PROJECT_TIMEZONE=${PROJECT_TIMEZONE_DEFAULT}
  fi
  tr -d '[:blank:]' < ${TIMEZONES_FILE} | sed '/^$/d' | sed -n 's/\//\//p' | sort > ${TIMEZONES_TMP_FILE}
  if ! grep -Fxq ${PROJECT_TIMEZONE} ${TIMEZONES_TMP_FILE}; then
    echo -e -n "${ANSI_ERROR}"' '
    echo $(echo 'Invalid time zone'' '"\"${PROJECT_TIMEZONE}\""' ' \
                '(consult file '"${TIMEZONES_FILE}"' ' \
                'to see the accepted time zones, time zone is case sensitive)' | tr -s ' ')
    echo ''
    exit 1
  fi
  PROJECT_TIMEZONE_SLASH_ESCAPED=$(echo ${PROJECT_TIMEZONE} | sed 's/\//\\\//g')
  sed -i 's/DOCKER_SYMFONY_TIMEZONE=/DOCKER_SYMFONY_TIMEZONE='"${PROJECT_TIMEZONE_SLASH_ESCAPED}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the time zone'' '"\"${PROJECT_TIMEZONE}\""' ''to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit 1
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Time zone "'"${PROJECT_TIMEZONE}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    return 0
  fi
}
