#!/usr/bin/env bash


#
# (c) 2023 Ricardo Ruiz Martínez <richiruizmartinez@gmail.com>
#


CONFIG_FILE='./setup.cnf'


# ----------------------------------------------------------------------------------------------------------------------
# functions
# ----------------------------------------------------------------------------------------------------------------------

clean() {
  if [ ${#} -ne 3 ]; then
    return 1
  fi
  echo $(echo ${1} | tr -d -c ${2} | fold -w ${3} | head -n 1)
  return 0
}

function echo_section() {
  echo -e "${ANSI_BOLD}${ANSI_FG_YELLOW}${1} ...${ANSI_DEFAULT}"
}

get_random_token() {
  if [ ${#} -ne 2 ]; then
    return 1
  fi
  echo $(tr -d -c ${1} < /dev/urandom | fold -w ${2} | head -n 1)
  return 0
}

intro() {
  echo -e ""
  echo -e "${ANSI_BG_BLUE}""$(printf '%*s' 66)""${ANSI_BG_DEFAULT}"
  echo -e "${ANSI_BG_BLUE}""$(printf '%*s' 3)""${ANSI_BOLD}${ANSI_FG_GREEN}${APP_NAME}${ANSI_FG_DEFAULT} version ${ANSI_FG_YELLOW}${APP_VERSION}${ANSI_FG_DEFAULT}${ANSI_BOLD_OFF}""$(printf '%*s' 19)""${ANSI_BG_DEFAULT}"
  echo -e "${ANSI_BG_BLUE}""$(printf '%*s' 3)""(c) $(date +%Y) ${AUTHOR_NAME} <${AUTHOR_EMAIL}>""$(printf '%*s' 3)""${ANSI_BG_DEFAULT}"
  echo -e "${ANSI_BG_BLUE}""$(printf '%*s' 66)""${ANSI_BG_DEFAULT}"
  echo -e "${ANSI_DEFAULT}"
}

load_config() {
  if [ ! -f ${CONFIG_FILE} ]; then
    echo -e -n "\e[1m\e[31mERROR:\e[0m"' '
    echo 'config file '"${CONFIG_FILE}"' does not exists'
    echo ''
    exit 1
  fi
  chmod 644 ${CONFIG_FILE}
  source ${CONFIG_FILE}
}

load_docker_env() {
  echo_section 'Loading Docker environment (from '"${DOCKER_ENVIRONMENT_FILE}"')'
  if [ ! -f ${DOCKER_ENVIRONMENT_FILE} ]; then
      echo -e -n "${ANSI_ERROR}"' '
      echo 'File'' '"${DOCKER_ENVIRONMENT_FILE}"' ''does not exist'
      echo ''
      exit
  fi
  source ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot load file '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit
  else
    echo -e -n "${ANSI_OK}"' '
    echo "${DOCKER_ENVIRONMENT_FILE}"' ''file loaded'
    echo ''
  fi
}

regenerate_docker_env_file() {
  echo_section 'Regenerating Docker environment ('"${DOCKER_ENVIRONMENT_FILE}"')'
  chmod 644 ${DOCKER_ENVIRONMENT_FILE} ${DOCKER_ENVIRONMENT_DIST_FILE} 2> /dev/null
  cp ${DOCKER_ENVIRONMENT_DIST_FILE} ${DOCKER_ENVIRONMENT_FILE} 2> /dev/null
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot regenerate file '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit
  else
    echo -e -n "${ANSI_OK}"' '
    echo "${DOCKER_ENVIRONMENT_FILE}"' ''file regenerated from template'' '"${DOCKER_ENVIRONMENT_DIST_FILE}"
    echo ''
  fi
}

set_ansi_ok_error_tags() {
  ANSI_OK="${ANSI_BOLD}${ANSI_BG_GREEN}${ANSI_FG_BLACK} ${ENVIRONMENT} OK ${ANSI_DEFAULT}"
  ANSI_ERROR="${ANSI_BOLD}${ANSI_FG_RED}ERROR:${ANSI_DEFAULT}"
}

set_database_name() {
  echo_section 'Database name'
  read -p 'Name your database (default: random name as a security measure):'' ' DB_NAME
  DB_NAME=$(clean "${DB_NAME}@" 'a-zA-Z0-9' ${DB_NAME_MAX_LENGTH})
  if [ "${DB_NAME}" = '' ]; then
    DB_NAME=$(get_random_token 'a-zA-Z0-9' ${DB_NAME_MAX_LENGTH})
  fi
  sed -i 's/DOCKER_SYMFONY_DB_NAME=/DOCKER_SYMFONY_DB_NAME='"${DB_NAME}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the database name "'"${DB_NAME}"'" to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Database name "'"${DB_NAME}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
  fi
}

set_database_root_password() {
  echo_section 'Database root password'
  DB_ROOT_PASSWORD=$(get_random_token ${PASSWORD_CHARSET} ${RANDOM_PASSWORD_LENGTH})
  sed -i 's/DOCKER_SYMFONY_DB_ROOT_PASSWORD=/DOCKER_SYMFONY_DB_ROOT_PASSWORD='"${DB_ROOT_PASSWORD}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the database root password "'"${DB_ROOT_PASSWORD}"'"'' ''to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Random database root password "'"${DB_ROOT_PASSWORD}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
  fi
}

set_database_user_name() {
  echo_section 'Database user name'
  read -p 'Database username (default: random name as a security measure):'' ' DB_USER_NAME
  if [ "${DB_USER_NAME}" = '' ]; then
    DB_USER_NAME=$(get_random_token 'a-zA-Z0-9' ${DB_USER_NAME_MAX_LENGTH})
  fi
  sed -i 's/DOCKER_SYMFONY_DB_USER_NAME=/DOCKER_SYMFONY_DB_USER_NAME='"${DB_USER_NAME}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the database username "'"${DB_USER_NAME}"'" to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Database username "'"${DB_USER_NAME}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
  fi
}

set_database_user_password() {
  echo_section 'Database user password'
  DB_USER_PASSWORD=$(get_random_token ${PASSWORD_CHARSET} ${RANDOM_PASSWORD_LENGTH})
  sed -i 's/DOCKER_SYMFONY_DB_USER_PASSWORD=/DOCKER_SYMFONY_DB_USER_PASSWORD='"${DB_USER_PASSWORD}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the database user password "'"${DB_USER_PASSWORD}"'" to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Random database user password "'"${DB_USER_PASSWORD}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
  fi
}

set_environment() {
  DOCKER_ENVIRONMENT_FILE="${DOCKER_ENVIRONMENT_FILE}"'.'"${1}"
  ENVIRONMENT=${1^^} # DEV | PROD
}

set_project_name() {
  echo_section 'Project name'
  read -p 'Name your project (default: "'"${PROJECT_NAME_DEFAULT}"'"):'' ' PROJECT_NAME
  PROJECT_NAME=$(clean "${PROJECT_NAME}@" 'a-zA-Z0-9_' ${PROJECT_NAME_MAX_LENGTH})
  if [ "${PROJECT_NAME}" = '' ]; then
    PROJECT_NAME=${PROJECT_NAME_DEFAULT}
  fi
  sed -i 's/DOCKER_SYMFONY_PROJECT_NAME=/DOCKER_SYMFONY_PROJECT_NAME='"${PROJECT_NAME}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the project name '"${PROJECT_NAME}"' to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Project name "'"${PROJECT_NAME}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
  fi
}

set_timezone() {
  echo_section 'Time zone'
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
    exit
  fi
  PROJECT_TIMEZONE_SLASH_ESCAPED=$(echo ${PROJECT_TIMEZONE} | sed 's/\//\\\//g')
  sed -i 's/DOCKER_SYMFONY_TIMEZONE=/DOCKER_SYMFONY_TIMEZONE='"${PROJECT_TIMEZONE_SLASH_ESCAPED}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the time zone'' '"\"${PROJECT_TIMEZONE}\""' ''to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Time zone "'"${PROJECT_TIMEZONE}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
  fi
}

function stop_docker_services() {
  echo_section 'Stopping Docker services'
  docker compose down 2> /dev/null
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot stop Docker services'
    echo ''
    exit
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Docker services stopped'
    echo ''
  fi
}

usage() {
  if [ "${#}" -ne '1' -o "${1}" != 'dev' -a "${1}" != 'prod' ]; then
    echo -n '   '
    echo -e "${ANSI_BOLD}${ANSI_FG_YELLOW}Usage:${ANSI_DEFAULT}"
    echo ''
    echo -n '      '
    echo -e "${ANSI_BOLD}${0}${ANSI_DEFAULT}"' ''dev|prod'
    echo '';
    exit
  fi
}

# ----------------------------------------------------------------------------------------------------------------------
# end functions
# ----------------------------------------------------------------------------------------------------------------------


# ----------------------------------------------------------------------------------------------------------------------
# main
# ----------------------------------------------------------------------------------------------------------------------

load_config
intro
usage ${@}
set_environment ${1}
set_ansi_ok_error_tags
regenerate_docker_env_file
set_project_name
set_timezone
set_database_name
set_database_root_password
set_database_user_name
set_database_user_password
load_docker_env
stop_docker_services
exit

# ----------------------------------------------------------------------------------------------------------------------
# end main
# ----------------------------------------------------------------------------------------------------------------------




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

echo -e "${ANSI_BOLD}${ANSI_FG_YELLOW}Starting Docker services ...${ANSI_DEFAULT}"
docker compose up -d --remove-orphans && \
  echo -e -n "${ANSI_OK}"' ' && \
  echo 'Containers running' && \
  echo ''

echo -e "${ANSI_BOLD}${ANSI_FG_YELLOW}Installing Symfony ...${ANSI_DEFAULT}"
if [ ! -z "$(ls -A ${APP_DIR_HOST})" ]; then
  echo 'app/ directory ('"${APP_DIR_HOST}"') must be empty'
  read -p 'Empty? [Yes/no] ' ANSWER
  ANSWER="${ANSWER^^}"
  if [ "${ANSWER}" = '' -o "${ANSWER:0:1}" = 'Y' ]; then
    docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" find ${APP_DIR_CONTAINER} -type f -exec rm {} \; && \
      docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" find ${APP_DIR_CONTAINER} -mindepth 1 -type d -exec rm -fr {} \; 2>/dev/null && \
      echo -e -n "${ANSI_OK}"' ' && \
      echo 'app/ directory ('"${APP_DIR_HOST}"') emptied'
  else
    echo ''
    exit
  fi
fi
docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" git config --global --add safe.directory /var/www/html && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" git config --global user.email "user@localhost" && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" git config --global user.name "user" && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" symfony new . && \
  echo -e -n "${ANSI_OK}"' ' && \
  echo 'Symfony installed!'
  echo ''

echo -e "${ANSI_BOLD}${ANSI_FG_YELLOW}Installing additional packages ...${ANSI_DEFAULT}"
docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" composer require symfony/monolog-bundle && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" composer require symfony/orm-pack && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" composer require --dev symfony/maker-bundle && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" composer require --dev richirm/qdump && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" composer update && \
  echo -e -n "${ANSI_OK}"' ' && \
  echo 'Additional packages installed'
  echo ''

mkdir -p ${UPLOADS_DIR_HOST} && \
  chmod 777 ${UPLOADS_DIR_HOST} && \
  echo -e -n "${ANSI_OK}"' ' && \
  echo 'uploads/ directory ('"${UPLOADS_DIR_HOST}"') created' && \
  echo ''
