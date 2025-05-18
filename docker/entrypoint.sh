#!/bin/sh

log_info() {
  echo "$1 \033[1;34m[$2]\033[0m \033[1;32m$3\033[0m" >> /proc/1/fd/1 2>> /proc/1/fd/2
}

log_error() {
  echo "$1 \033[1;31m[$2] $3\033[0m" >> /proc/1/fd/1 2>> /proc/1/fd/2
}

# Load .env vars
if [ -f /.env ]; then
  set -a
  . /.env
  set +a
  log_info "🥳" "i" "Loaded all environment variables from /.env"
else
  log_error "❌" "e" "Could not find /.env file - make sure to rename .env.example to .env!"
fi

log_info "🧸" "i" "Using INSTANCE_URL: $WEB_URL on port $WEB_PORT"

# Se the command as an alias.
echo "alias marchive='/usr/local/bin/php /var/www/html/console core:archive --url=$WEB_URL'" >> /etc/profile

# Enforce environment variables to get correct PATH.
. /etc/profile

# Add cron job to generate Matomo reports.
echo "$MATOMO_ARCHIVE_INTERVAL /usr/local/bin/php /var/www/html/console core:archive --url=$WEB_URL >> /var/log/cron.log 2>&1" | crontab -

# Archive once to ensure it's working.
marchive >> /var/log/cron.log 2>&1

# Start cron in the background.
cron

# Start Apache in the foreground.
apache2-foreground
