# Webex, docked

`sudo docker build -t frumioj/webex-docked -f Dockerfile .`

`xhost +` is needed to disable X11 access control, which is needed to allow the Webex app to connect to the docker host X11 server

You have to mount volumes for ALSA/Pulseaudio support, and also for X11 server (in addition to setting the environment variables. 

`sudo docker run -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/$USER/:/home/user -v /dev/shm:/dev/shm -v "/etc/alsa:/etc/alsa" -v "/usr/share/alsa:/usr/share/alsa" -v "/home/$USER/.config/pulse:/home/user/.config/pulse" -v "/run/$USER/$UID/pulse/native:/run/user/$UID/pulse/native" --env "PULSE_SERVER=unix:/run/user/$UID/pulse/native" --device /dev/dri --privileged -e "DISPLAY=unix:0.0" -d -t frumioj/webex-docked`

It's probably advisable to run `xhost -` after the command has completed, to enable access control again.

Note: `xauth` can probably be used to prevent the need to open up access completely, but I haven't done that yet!