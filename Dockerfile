FROM ich777/debian-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-steamcmd-server"

RUN apt-get update && \
	apt-get -y install --no-install-recommends lib32gcc-s1 lib32stdc++6 lib32z1 && \
	rm -rf /var/lib/apt/lists/*

ENV DATA_DIR="/home/container"
ENV STEAMCMD_DIR="/home/container/steamcmd"
ENV SERVER_DIR="/home/container/serverfiles"
ENV GAME_ID="4020"
ENV GAME_NAME="garrysmod"
ENV GAME_PARAMS="-secure +maxplayers 12 +map gm_flatgrass"
ENV GAME_PORT=27015
ENV VALIDATE=""
ENV UMASK=000
ENV UID=99
ENV GID=101
ENV USERNAME=""
ENV PASSWRD=""
ENV USER="steam"
ENV DATA_PERM=777

RUN mkdir $DATA_DIR && \
	mkdir $STEAMCMD_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
