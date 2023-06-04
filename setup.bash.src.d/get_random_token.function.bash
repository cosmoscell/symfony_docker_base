get_random_token() {
  if [ ${#} -ne 2 ]; then
    return 1
  fi
  echo $(tr -d -c ${1} < /dev/urandom | fold -w ${2} | head -n 1)
  return 0
}
