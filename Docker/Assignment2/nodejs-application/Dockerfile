FROM node:20-alpine
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Install curl for health checks.
# 'apk update' updates the package lists.
# 'apk add curl' installs curl.
# 'rm -rf /var/cache/apk/*' cleans up the cache to keep the image small.
RUN apk update && apk add curl && rm -rf /var/cache/apk/*

EXPOSE 3000

# HEALTHCHECK instruction
# --interval=30s: Checks every 30 seconds.
# --timeout=10s: Fails if the check takes longer than 10 seconds.
# --retries=3: Marks as unhealthy after 3 consecutive failures.
# --start-period=5s: Gives the app 5 seconds to start up before health check failures count.
# CMD curl -f http://localhost:3000/ || exit 1:
#   Attempts to make an HTTP request to your app's main endpoint.
#   '-f' makes curl fail on HTTP errors (4xx/5xx responses).
#   '|| exit 1' ensures the command returns a non-zero exit code if curl fails,
#   signaling an unhealthy state to Docker.
HEALTHCHECK --interval=30s --timeout=10s --retries=3 --start-period=5s \
  CMD curl -f http://localhost:3000/ || exit 1

CMD ["node", "app.js"]
