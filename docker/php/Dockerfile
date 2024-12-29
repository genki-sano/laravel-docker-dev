FROM php:8.3-fpm

RUN apt-get update \
    && apt-get install -y --no-install-recommends git curl zip unzip vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install opcache bcmath pdo_mysql mysqli

# composerインストール
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Node.jsのインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    node --version && yarn --version
ENV PATH="/usr/local/bin:${PATH}"

WORKDIR /var/www/html
