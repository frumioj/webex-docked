# Webex in a container
#
# sudo docker run -d --cpus="3"
#             -v /tmp/.X11-unix:/tmp/.X11-unix \
#             -v /home/$USER/:/home/user \
#      	      -v /dev/shm:/dev/shm \
#	      -v "/etc/alsa:/etc/alsa" \
#	      -v "/usr/share/alsa:/usr/share/alsa" \
#	      -v "/home/$USER/.config/pulse:/home/user/.config/pulse" \
#	      -v "/run/$USER/$UID/pulse/native:/run/user/$UID/pulse/native"
#	      --env "PULSE_SERVER=unix:/run/user/$UID/pulse/native"
#	      --device /dev/dri --privileged
#	      -e "DISPLAY=unix:0.0" frumioj/webex-docked
	     
FROM ubuntu:20.04
LABEL maintainer "John Kemp <stable.pseudonym@gmail.com>"
ENV DEBIAN_FRONTEND noninteractive

# Add opengl libs, gtk, and wget
RUN apt-get update \
    && apt-get install -y -qq --no-install-recommends wget libgtk-3-0 libglvnd0 libgl1 libglx0 libegl1 libxext6 libx11-6

# Grab the Webex package from the official(!) site
RUN wget --no-check-certificate https://binaries.webex.com/WebexDesktop-Ubuntu-Official-Package/Webex.deb

RUN apt-get install -y ./Webex.deb

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

WORKDIR $HOME

CMD [ "start.sh" ]