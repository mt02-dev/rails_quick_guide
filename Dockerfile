FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    gpg \
    libnss3-dev \
    lsb-release \
    nodejs \
    software-properties-common \
    tzdata \
    unzip \
    wget
RUN bash -c "curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg" && \
    echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/redis.list && \
    apt-get update && \
    apt-get install redis
# chrome　ブラウザを同コンテナで利用する際に必要と思われる設定(現状うまくいってない)
# WORKDIR /tmp
# RUN CHROMEDRIVER_VERSION=`curl -sS https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_STABLE` && \
#     curl -sS -o chromedriver_linux64.zip https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROMEDRIVER_VERSION/linux64/chromedriver-linux64.zip && \
#     unzip chromedriver_linux64.zip && \
#     mv chromedriver-linux64/chromedriver /usr/local/bin/ && \
#     sh -c 'curl -fSsL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | tee /usr/share/keyrings/google-chrome.gpg >> /dev/null' && \
#     sh -c 'echo deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main | tee /etc/apt/sources.list.d/google-chrome.list' && \
#     apt-get update && \
#     apt-get install -y google-chrome-stable
WORKDIR /taskleaf
COPY Gemfile Gemfile.lock ./
RUN bundle install
