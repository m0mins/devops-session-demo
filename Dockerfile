FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt gunicorn

# Switch to root to install packages
USER root

# Install nginx
RUN apt-get update && apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Remove default nginx config and copy our shared one
RUN rm /etc/nginx/nginx.conf
COPY scripts/nginx/default.conf /etc/nginx/nginx.conf

COPY . .

# CMD ["sh", "-c", "gunicorn --bind 0.0.0.0:${PORT} app.main:app"]

# CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app.main:app"]
CMD ["sh", "-c", "service nginx start && gunicorn --bind 0.0.0.0:5000 app.main:app"]
# CMD ["sh", "-c", "nginx -g 'daemon off;' & gunicorn --bind 0.0.0.0:5000 app.main:app"]
