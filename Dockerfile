# npm with node 10.10
FROM gcr.io/cloud-builders/npm@sha256:fd30b25ab0412ff18ae0b005b33a9405bb34890dd1540a732dfd97804bb02148

LABEL name="chrome-headless-with-npm:node-10.10" \
    maintainer="Bunny Vishal <vishal@bunnyvishal.com>" \
    version="1.0" \
    description="Google Chrome Headless with NPM(from Google cloud registry) in a container"


# Some Debain repo sourcelist corrections
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

# Install deps + add Chrome Stable + purge all the things
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    --no-install-recommends \
    && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable \
    fontconfig \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-noto \
    ttf-freefont \
    --no-install-recommends


# Add Chrome as a user
RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
    && mkdir -p /home/chrome && chown -R chrome:chrome /home/chrome \
    && mkdir -p /opt/google/chrome && chown -R chrome:chrome /opt/google/chrome

