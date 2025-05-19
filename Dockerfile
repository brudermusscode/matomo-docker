FROM matomo:latest

# Install cron
RUN apt-get update && apt-get install -y cron nano && rm -rf /var/lib/apt/lists/*

# Copy all files to /data and set .sh files as executables.
COPY . /data
RUN chmod +x /data/docker/entrypoint.sh /data/docker/archive.sh /data/docker/wait-for-it.sh

# Copy environment file
COPY .env /.env

WORKDIR /var/www/html

# Use the custom entrypoint script
ENTRYPOINT ["/data/docker/entrypoint.sh"]