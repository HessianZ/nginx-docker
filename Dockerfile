FROM nginx:1.19.5-alpine

# 修改时区
#
RUN set -x \
 && export ALPINE_VERSION=$(sed 's/\.\d\+$//' /etc/alpine-release) \
 && echo "https://mirrors.cloud.tencent.com/alpine/v${ALPINE_VERSION}/main" > /etc/apk/repositories \
 && echo "https://mirrors.cloud.tencent.com/alpine/v${ALPINE_VERSION}/community" >> /etc/apk/repositories \
 && apk add tzdata && cp /usr/share/zoneinfo/PRC /etc/localtime && apk del tzdata

VOLUME /etc/nginx
VOLUME /data/www
