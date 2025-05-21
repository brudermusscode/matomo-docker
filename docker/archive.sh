#!/bin/sh

log_info() {
  echo "$1 \033[1;34m[$2]\033[0m \033[1;32m$3\033[0m" >> /proc/1/fd/1 2>> /proc/1/fd/2
}

# This script will only be fired in a running container. If the
# .env file exists is checked at startup, so it will always be available.
. /.env

# Run the archiving command.
/usr/local/bin/php /var/www/html/console core:archive --url="$WEB_URL" >> $CRON_LOG_PATH 2>&1

log_info "💋" "MATOMO" "Archiving complete!"