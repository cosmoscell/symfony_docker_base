load_config() {
  if [ ! -f ${CONFIG_FILE} ]; then
    echo -e -n "\e[1m\e[31mERROR:\e[0m"' '
    echo 'config file '"${CONFIG_FILE}"' does not exists'
    echo ''
    exit 1
  fi
  chmod 644 ${CONFIG_FILE}
  source ${CONFIG_FILE}
  return 0
}
