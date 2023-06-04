clean_string() {
  if [ ${#} -ne 3 ]; then
    return 1
  fi
  echo $(echo ${1} | tr -d -c ${2} | fold -w ${3} | head -n 1)
  return 0
}
