# Thunderbird in a container
#
# sudo docker run --cpus="3" -d \
#             -v /tmp/.X11-unix:/tmp/.X11-unix \
#             -v /home/johnk/:/home/user \
#             -v /etc/localtime:/etc/localtime:ro \
#             -e DISPLAY=unix$DISPLAY \
#             --device /dev/dri frumioj/webex-docked

FROM ubuntu:18.04
LABEL maintainer "John Kemp <stable.pseudonym@gmail.com>"

RUN apt-get update \
    && apt-get install -y wget

RUN wget https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/Webex.deb

RUN apt-get install -y ./Webex.deb

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

WORKDIR $HOME

CMD [ "start.sh" ]