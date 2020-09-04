FROM python:3.8.5

ENV CHROMEDRIVER_VERSION=85.0.4183.83
ENV DOCKER_COMPOSE_VERSION=1.19.0

# Install chromedriver, heroku CLI, and coveralls
RUN apt-get update -y && apt-get install -y chromium libgconf-2-4 unzip sudo apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
	curl -L -O https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
	unzip chromedriver_linux64.zip -d /usr/local/bin && \
        chmod +x /usr/local/bin/chromedriver && \
	rm chromedriver_linux64.zip && \
	curl -L https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x64.tar.gz | tar -zxv && \
	mv heroku* /usr/local/lib/heroku && ln -s /usr/local/lib/heroku/bin/heroku /usr/local/bin/heroku && \
        pip install --upgrade pip && \
	pip install pipenv coveralls && \
        curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > ~/docker-compose && \
        chmod +x ~/docker-compose && \
        sudo mv ~/docker-compose /usr/local/bin/docker-compose && \
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - && \
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian  $(lsb_release -cs) stable" && \
	sudo apt-get update && \
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io && \
	useradd -m ci && echo 'ci ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ADD ssh_config /home/ci/.ssh/config
RUN chown -R ci:ci /home/ci/.ssh

USER ci
WORKDIR /home/ci
