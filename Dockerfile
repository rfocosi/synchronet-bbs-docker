FROM debian:bullseye

ENV SBBSCTRL=/sbbs/ctrl

RUN apt update && \
    apt install -y build-essential lib32ncurses-dev libnspr4-dev libcrypto++-dev libssl-dev avr-libc liblhasa-dev libxbase64-dev cvs libcap2-dev zip pkg-config python2 wget autoconf

RUN mkdir /sbbs

WORKDIR /sbbs

COPY GNUmakefile /sbbs/

RUN cd /sbbs && \
    make install SYMLINK=1

CMD ["/sbbs/exec/sbbs"]
