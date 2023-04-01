FROM alpine:latest as git
RUN apk update
ARG VERSION=0.3.9
RUN wget -q -O JMusicBot.jar -- https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION.jar

#---#

FROM amazoncorretto:8u362-alpine3.17-jre

ARG VERSION

LABEL maintainer="Justin Chen <chennickyjustin@gmail.com>" \
    org.opencontainers.image.authors="Justin Chen<chennickyjustin@gmail.com>" \
    org.opencontainers.image.url="https://github.com/chen-justin/musicbot/tree/main" \
    org.opencontainers.image.source="https://github.com/chen-justin/musicbot" \
    org.opencontainers.image.documentation="https://github.com/jagrosh/MusicBot/wiki/" \
    org.opencontainers.image.vendor="chen-justin" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.title="MusicBot" \
    org.opencontainers.image.description="A dockerized version of jagrosh's music bot"

RUN export user=MusicBot \
    && export group=MusicBot \
    && addgroup -S $group && adduser -S $user -G $group

COPY --from=git [ "/JMusicBot.jar", "/JMusicBot.jar" ]

WORKDIR /data
CMD [ "java", "-Dnogui=true", "-jar", "/JMusicBot.jar" ]