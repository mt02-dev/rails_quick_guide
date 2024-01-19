FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    git \
    libnss3-dev \
    nodejs \
    software-properties-common \
    tzdata \
    unzip \
    wget
WORKDIR /tmp
RUN CHROMEDRIVER_VERSION=`curl -sS https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_STABLE` && \
    curl -sS -o chrome-headless-shell-linux64.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${CHROMEDRIVER_VERSION}/linux64/chrome-headless-shell-linux64.zip && \
    unzip chrome-headless-shell-linux64.zip && \
    mv chrome-headless-shell-linux64/chrome-headless-shell /usr/local/bin/ && \
    sh -c 'curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | tee /usr/share/keyrings/google-chrome.gpg >> /dev/null' && \
    sh -c 'echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | tee /etc/apt/sources.list.d/google-chrome.list' && \
    apt-get update && \
    apt-get install -y google-chrome-stable
WORKDIR /taskleaf
COPY Gemfile Gemfile.lock ./
RUN bundle install
