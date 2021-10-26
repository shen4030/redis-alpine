FROM alpine

ENV TIMEZONE            Asia/Shanghai
# 阿里源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update \
    && apk upgrade \
    && apk add \
    tzdata \
    redis \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && apk del tzdata \
    && rm -rf /var/cache/apk/*

COPY conf/redis.conf /etc/redis.conf

CMD ["redis-server", "/etc/redis.conf"]

EXPOSE 6379
