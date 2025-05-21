#!/bin/sh

. /data/docker/logger.sh

ARCHIVE_PATH="/data/docker/archive.sh"

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
echo "alias marchive='$ARCHIVE_PATH'" >> /etc/profile
log_info "🦾" "i" "Added archiving alias: marchive"

# Enforce environment variables to get correct PATH.
. /etc/profile

# Add cron job to generate Matomo reports.
echo "$MATOMO_ARCHIVE_INTERVAL $ARCHIVE_PATH" | crontab -
log_info "⏱️ " "i" "Added archiving cronjob with interval $MATOMO_ARCHIVE_INTERVAL"

log_info "🫴 " "i" "PHP memory limit should be $PHP_MEMORY_LIMIT"

# Archive once to ensure it's working.
log_info "🗿" "i" "Running first archive..."
marchive >> $CRON_LOG_PATH 2>&1
log_info "💋" "MATOMO" "Archiving complete!"

# Start cron in the background.
cron

# Start Apache in the foreground.
apache2-foreground
