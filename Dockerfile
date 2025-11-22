FROM alpine AS build

RUN apk update
RUN apk add --no-cache git build-base autoconf automake libtool pkgconf zlib-dev openssl-dev avahi-dev poppler-dev

RUN git -v
RUN git clone --recursive https://github.com/istopwg/ippsample.git
WORKDIR /ippsample
RUN mkdir build
RUN ./configure --disable-shared --enable-static --prefix=/ippsample/build
RUN make -j$(nproc)
RUN make install

FROM flungo/avahi

COPY --from=build /ippsample/build/ /usr/local/

COPY avahi.sh /opt/avahi.sh

RUN apk add --no-cache dbus

ENTRYPOINT ["/opt/avahi.sh"]
