FROM node:12.18.4

RUN apt-get update -y && apt-get install -y chromium libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb && \
	useradd -m ci && echo 'ci ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER ci
WORKDIR /home/ci
