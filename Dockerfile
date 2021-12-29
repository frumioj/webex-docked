# Thunderbird in a container
#
# docker run --cpus="3" -d \
#            -v /tmp/.X11-unix:/tmp/.X11-unix \
#            -v /home/johnk/:/home/user \
#            -e DISPLAY=unix$DISPLAY \
#            --device /dev/dri \
#            frumioj/tbird-docked

FROM fedora:34
LABEL maintainer "John Kemp <stable.pseudonym@gmail.com>"

RUN dnf update -y \
    && dnf install -y thunderbird \
    && dnf clean all \
    && rm -rf /var/cache/yum

ENV HOME /home/user
RUN useradd --create-home --home-dir $HOME user \
	&& chown -R user:user $HOME

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

WORKDIR $HOME

CMD [ "start.sh" ]