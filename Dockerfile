FROM ubuntu

RUN apt-get update
RUN apt-get -y install lib32gcc1 libc6-i386 wget

ENV DATA_DIR="/home/container/serverdata"
ENV STEAMCMD_DIR="$/home/container/steamcmd"
ENV SERVER_DIR="$/home/container/serverfiles"
ENV GAME_ID="4020"
ENV GAME_NAME="garrysmod"
ENV GAME_PARAMS="-secure +maxplayers 12 +map gm_flatgrass"
ENV GAME_PORT=27015

RUN mkdir $DATA_DIR
RUN mkdir $STEAMCMD_DIR
RUN mkdir $SERVER_DIR

# RUN wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz \
#  &&  tar --directory ${STEAMCMD_DIR} -xvzf ${STEAMCMD_DIR}/steamcmd_linux.tar.gz \
#  &&  rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz \
#  &&  chmod -R 774 $STEAMCMD_DIR  $SERVER_DIR 
RUN ulimit -n 2048

ADD /home/container/ /home/container/
#RUN chmod -R 774 /opt/scripts/

#Server Start
ENTRYPOINT ["/home/container/start-server.sh"]
