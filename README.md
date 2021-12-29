# Thunderbird, docked

Thunderbird is an excellent mail reader, but it uses a tonne of CPU which sets the fans going on my machine. I wanted to stop that, and in general find a way to have it not kill my machine. Dockerizing it, and giving it access to my local mail profile, gives me that control (and possibly more, if I want it).

Note: if you have Thunderbird already installed, make sure that the version is roughly the same as you'll use in your docker machine, otherwise it will want to create a new profile for you, rather than using the one you already have in ~/.thunderbird.

`docker run --cpus="3" -d -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/johnk/:/home/user -e DISPLAY=unix$DISPLAY --device /dev/dri frumioj/tbird-docked`
