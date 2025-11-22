FROM debian:13 AS build

RUN apt update && \
    apt install -y git cups gcc make zlib1g-dev openssl libavahi-core-dev libpoppler-dev

RUN apt install -y avahi-utils libavahi-client-dev libavahi-common-dev libavahi-core-dev

RUN apt install -y libssl-dev libssl3

RUN apt install -y avahi-daemon

RUN git -v
RUN git clone --recursive https://github.com/istopwg/ippsample.git
WORKDIR /ippsample
RUN mkdir build
RUN ./configure --disable-shared --enable-static --prefix=/ippsample/build
RUN make -j$(nproc)
RUN make install

FROM debian:13

COPY --from=build /ippsample/build/ /usr/local/

RUN apt update && \
    apt install -y cups avahi-daemon openssl

