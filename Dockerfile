FROM debian:12

RUN apt update && \
    apt install -y git cups gcc make zlib1g-dev openssl libavahi-core-dev libpoppler-dev

RUN apt install -y avahi-utils libavahi-client-dev libavahi-common-dev libavahi-core-dev

RUN apt install -y libssl-dev libssl3

RUN git -v
RUN git clone --recursive https://github.com/istopwg/ippsample.git
WORKDIR /ippsample
RUN ./configure --disable-shared --enable-static
RUN make
RUN make install
