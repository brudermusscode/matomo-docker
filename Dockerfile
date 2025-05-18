FROM matomo:latest

# Install cron
RUN apt-get update && apt-get install -y cron nano && rm -rf /var/lib/apt/lists/*

# Add the entrypoint script to handle cron and Apache
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Wait for certain services to be running.
COPY docker/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Copy environment file
COPY .env /.env

WORKDIR /var/www/html

# Use the custom entrypoint script
ENTRYPOINT ["/entrypoint.sh"]