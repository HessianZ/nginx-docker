FROM nginx:1.19.5-alpine

# 生产环境配置
ENV NGINX_UID=1000 \
    NGINX_GID=1000

# 修改时区
#
RUN set -x \
 && export ALPINE_VERSION=$(sed 's/\.\d\+$//' /etc/alpine-release) \
 && echo "https://mirrors.cloud.tencent.com/alpine/v${ALPINE_VERSION}/main" > /etc/apk/repositories \
 && echo "https://mirrors.cloud.tencent.com/alpine/v${ALPINE_VERSION}/community" >> /etc/apk/repositories \
 && sed -i "s/:101:101:/:${NGINX_UID}:${NGINX_GID}:/g" /etc/passwd \
 && sed -i "s/:101:/:${NGINX_GID}:/g" /etc/group \
 && apk add tzdata && cp /usr/share/zoneinfo/PRC /etc/localtime && apk del tzdata

VOLUME /etc/nginx
VOLUME /data/www
