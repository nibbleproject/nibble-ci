FROM node:12.18.4

RUN apt-get update -y && apt-get install -y chromium && \
	useradd -m ci && echo 'ci ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER ci
WORKDIR /home/ci
