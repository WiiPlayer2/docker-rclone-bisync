FROM ubuntu:latest
RUN apt-get update \
    && apt-get install -y git nodejs npm cron curl unzip \
    && apt-get clean \
    && curl https://rclone.org/install.sh | bash \
    && git clone https://github.com/chadj/rclone-bisync.git \
    && rm -rv rclone-bisync/.git \
    && cd rclone-bisync \
    && npm install \
    && touch /var/log/cron.log
VOLUME [ "/config", "/data" ]

ENV REMOTE_NAME="remote"
ENV REMOTE_TYPE="dropbox"

COPY crontab /etc/cron.d/sync-cron
COPY run.sh /run.sh
COPY sync.sh /sync.sh
RUN chmod 0755 run.sh \
    && chmod 0755 sync.sh
CMD /run.sh
