# Build Flutter web, serve static files with nginx (local / Traefik stack).
FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app

RUN flutter config --enable-web

COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

COPY . .

ARG API_BASE_URL=http://127.0.0.1:8000

RUN flutter build web --release \
  --dart-define=API_BASE_URL=${API_BASE_URL}

FROM nginx:1.27-alpine
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
