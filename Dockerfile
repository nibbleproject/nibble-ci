FROM python:3.6.7

ENV CHROMEDRIVER_VERSION=73.0.3683.68

# Install chromedriver, heroku CLI, and coveralls
RUN apt update -y && apt install -y chromium libgconf2-4 unzip sudo && \
	curl -L -O https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
	unzip chromedriver_linux64.zip -d /usr/local/bin && \
        chmod +x /usr/local/bin/chromedriver && \
	rm chromedriver_linux64.zip && \
	curl -L https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x64.tar.gz | tar -zxv && \
	mv heroku* /usr/local/lib/heroku && ln -s /usr/local/lib/heroku/bin/heroku /usr/local/bin/heroku && \
        pip install --upgrade pip && \
	pip install pipenv coveralls && \
	useradd -m ci && echo 'ci ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

ADD ssh_config /home/ci/.ssh/config
RUN chown -R ci:ci /home/ci/.ssh

USER ci
WORKDIR /home/ci
