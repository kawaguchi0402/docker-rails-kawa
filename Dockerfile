# FROM：使用するイメージ、バージョン
FROM ruby:3.1
# 公式→https://hub.docker.com/_/ruby

# Rails 7ではWebpackerが標準では組み込まれなくなったので、yarnやnodejsのインストールが不要

# ruby3.1のイメージがBundler version 2.3.7で失敗するので、gemのバージョンを追記
ARG RUBYGEMS_VERSION=3.3.20

# RUN：任意のコマンド実行
RUN mkdir /app

RUN apt-get update && apt-get install -y locales \
    && sed -i -e 's/# \(ja_JP.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=ja_JP.UTF-8

ENV LC_ALL ja_JP.UTF-8

ENV TZ Asia/Tokyo
ENV LANG=ja_JP.UTF-8

# WORKDIR：作業ディレクトリを指定
WORKDIR /app

# COPY：コピー元とコピー先を指定
# ローカルのGemfileをコンテナ内の/app/Gemfileに
COPY Gemfile /app/Gemfile

COPY Gemfile.lock /app/Gemfile.lock

# RubyGemsをアップデート
RUN gem update --system ${RUBYGEMS_VERSION} && \
    bundle install

COPY . /app

# CMD:コンテナ実行時、デフォルトで実行したいコマンド
# Rails サーバ起動
CMD ["rails", "server", "-b", "0.0.0.0"]