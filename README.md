# Sensorgnome Dockcross

Docker is used to build packages for ARM on non-arch machines using the dockercross image.
This repo contains instructions on how to build the initial dockcross image for armv7 using
debian bullseye and it contains a Dockerfile to build a derivative image that adds a bunch of
libraries to the plain dockcross image.

tl;dr; you can use the tvoneicken/sensorgnome-armv7-rpi-bullseye image from DockerHub.

As of January 2022 the Raspberry Pi OS uses Debian bullseye. The standard/public dockcross image
works well for rPi with the ARMv7 architecture (basically rPi3 and later). ARMv6 has not been tested.

The dockercross image thus generated is generic -- to compile anything.
It is further customized for SG by installing specific dependencies, which is what the Dockerfile
in this repo accomplishes.
While it may seem odd to split the customization into two steps it does serve a useful
purpose. The dockercross image customized for rPi should work for as long as rPi OS is based
on bullseye. The additional SG dependencies may well change as the SG software changes.

### Buster-based images (deprecated)

The dockercross image used to build packages is somewhat tricky.
Dockercross is a general-purpose docker image to enable cross-compilation for a variety of architectures
and operating system on almost any x64 machine. Unfortunately it is not designed to specifically
support the Raspberry Pi OS and as a result a modified version of dockercross must be used.

As of October 2021 the Raspberry Pi OS used Debian buster, GCC 8.3, and glibc 2.28.
In order to successfully build packages for the rPi a version of dockercross must be built that
uses (more or less) exactly these software versions. This can be accomplished as follows:
- start with dockercross at commit `12a662e`, which is the last commit that uses buster
- replace `linux-armv7/crosstool-ng.config` with the file of the same name in this directory.
- build the linux-armv7 image (`make linux-armv7`)
