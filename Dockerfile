# Raspberry Pi OS used in this build is based on Debian bullseye. We need to use a version of
# dockcross that is also based on bullseye so it uses the same compiler version and the same
# shared library versions as will be found on the rPi.
# The public dockcross image works for rPi OS based on bullseye

# dockcross produced by TvE and uploaded to dockerhub
FROM tvoneicken/linux-armv7-rpi-bullseye
# local dockcross image produced according to readme
#FROM dockcross/linux-armv7

ENV DEFAULT_DOCKCROSS_IMAGE sensorgnome-armv7-rpi-bullseye

# Install Raspberry PI packages needed to build our apps using the dpkg/apt multi-arch feature:
# https://wiki.debian.org/Multiarch/HOWTO
RUN dpkg --add-architecture armhf &&\
    apt-get update &&\
    apt-get install --yes \
        libfftw3-3:armhf \
        libfftw3-dev:armhf \
        vamp-plugin-sdk:armhf \
        libasound2-dev:armhf \
        libssl-dev:armhf \
        autoconf:armhf \
        device-tree-compiler:armhf \
        zlib1g:armhf \
        zlib1g-dev:armhf \
        libusb-1.0-0:armhf \
        libusb-1.0-0-dev:armhf \
        libusb-0.1-4:armhf \
        libusb-dev:armhf \
        autoconf:armhf \
        libtool:armhf \
        libsqlite3-dev:armhf \
        libsqlite3-0:armhf \
        libvamp-hostsdk3v5:armhf \
        libhwloc-plugins:armhf \
        libmpdec3 \
        libmpdec-dev \
        libudev-dev:armhf \
        libudev1:armhf \
        libboost-dev:armhf \
        libboost-thread-dev:armhf \
        libboost-filesystem-dev:armhf \
        python3-minimal \
        python3-dev \
        libpython3-dev \
        libpython3-stdlib \
        python3-pip &&\
    apt-get clean --yes

# Install pip and Python dependencies.
RUN pip3 install gitpython pytz filehash

# After we install the various C/C++ dependencies, we need to symlink them into the crosscompiler.
ADD docker_symlinks.py /work/docker_symlinks.py
RUN python3 docker_symlinks.py
