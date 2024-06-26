# This is a multi-stage Dockerfile
# The first stage is used to build the app
# The second stage is used to run the app

# * Stage 1 - Install dependencies and build the app in a build environment
FROM debian:latest AS builder

# Install flutter dependencies
RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback python3 sed

# Clone the flutter repo
RUN git clone -b "3.19.6" https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter path
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

# Run flutter standard commands
RUN flutter config --enable-web
RUN flutter doctor -v

# Copy files to container and build (also get dependencies and execute build_runner)
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter pub get
RUN flutter pub run build_runner build --delete-conflicting-outputs
RUN flutter build web --no-tree-shake-icons --release --target lib/main_production.dart --web-renderer html

# * Stage 2 - Create the run-time image
FROM nginx:stable-alpine AS runner

# Copy the build output to replace the default nginx contents.
COPY --from=builder /app/build/web /usr/share/nginx/html

# Modify the default.conf file to add the following line
# try_files $uri $uri/ /index.html;
# ? This is to make sure that the index.html file is served when the user navigates to a route that is not defined
COPY nginx.default.conf /etc/nginx/conf.d/default.conf