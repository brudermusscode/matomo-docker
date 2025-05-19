# File containing logging options which can be included and then
# used around other sh files. This should keep everything straight forward.

log_info() {
  echo "$1 \033[1;34m[$2]\033[0m \033[1;32m$3\033[0m" >> /proc/1/fd/1 2>> /proc/1/fd/2
}

log_error() {
  echo "$1 \033[1;31m[$2] $3\033[0m" >> /proc/1/fd/1 2>> /proc/1/fd/2
}