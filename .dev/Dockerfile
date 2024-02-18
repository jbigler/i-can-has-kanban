ARG RUBY_VER=3.2.3

# Base image
# Alpine 3.19 introduces some breaking changes in gems.
FROM ruby:${RUBY_VER}-alpine3.18 as base

ENV APP_PATH=/app
ARG APP_USER=appuser
ENV APP_USER=${APP_USER}
ARG APP_GROUP=appgroup
ENV APP_GROUP=${APP_GROUP}
ARG APP_USER_UID=1000
ENV APP_USER_UID=${APP_USER_UID}
ARG APP_GROUP_GID=1000
ENV APP_GROUP_GID=${APP_GROUP_GID}

# gcompat is currently needed for Tailwindcss to work in Alpine.
ENV BUILD_PACKAGES="curl-dev ruby-dev build-base zsh xdg-user-dirs" \
    DEV_PACKAGES="ctags gzip py3-pip unzip zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev" \
    VIM_PACKAGES="xclip stylua tree-sitter nodejs npm python3 go alpine-sdk neovim fd fd-zsh-completion fzf git lazygit ripgrep bottom lua xclip" \
    RUBY_PACKAGES="ruby-json jemalloc" \
    RAILS_PACKAGES="build-base gcompat vips tzdata git"

# Configure Bundler
ENV BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

RUN --mount=type=cache,target=/var/cache/apk \
    apk update && \
    apk upgrade && \
    apk add --update \
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $VIM_PACKAGES \
    $RUBY_PACKAGES \
    $RAILS_PACKAGES

ENV LD_PRELOAD=/usr/lib/libjemalloc.so.2

RUN --mount=type=cache,target=$BUNDLE_APP_CONFIG \
    gem update --system && \
    gem install -N bundler && \
    mkdir -p $APP_PATH

COPY extra/Gemfile* $APP_PATH/

RUN addgroup -g $APP_GROUP_GID $APP_GROUP \
  && adduser -G $APP_GROUP -u $APP_USER_UID $APP_USER -s /bin/zsh --disabled-password \
  && chgrp -R $APP_GROUP $BUNDLE_APP_CONFIG \
  && chmod -R g+w $BUNDLE_APP_CONFIG \
  && chown -R $APP_USER:$APP_GROUP $APP_PATH 

USER $APP_USER
WORKDIR $APP_PATH
RUN bundle install

# Rails image
FROM base as rails

ENV RAILS_LOG_TO_STDOUT="1"
ENV BINDING="0.0.0.0"

USER $APP_USER

EXPOSE 3000
EXPOSE 7777

CMD ["bin/dev"]
