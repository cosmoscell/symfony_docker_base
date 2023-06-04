set_environment() {
  DOCKER_ENVIRONMENT_FILE="${DOCKER_ENVIRONMENT_FILE}"'.'"${1}"
  ENVIRONMENT=${1^^} # DEV | PROD
  return 0
}
