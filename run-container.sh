docker run \
  --privileged \
  -ti \
  -e DISPLAY \
  -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v ~/Docker/Wine:/home/docker/wine \
docker-arch-wine /bin/bash
