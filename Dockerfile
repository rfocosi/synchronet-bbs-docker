FROM debian:bullseye

ENV SBBSCTRL=/sbbs/ctrl

RUN apt update && \
    apt install -y build-essential libnspr4-dev \
                   libcrypto++-dev libssl-dev avr-libc liblhasa-dev \
                   libxbase64-dev libcap2-dev pkg-config autoconf cvs \
                   lib32ncurses-dev zip python2 \
                   wget rsync

RUN mkdir /sbbs-static

COPY GNUmakefile /sbbs-static/

RUN cd /sbbs-static && \
    make install

RUN rm -rf /sbbs-static/src/ && \
    apt purge -y build-essential pkg-config autoconf cvs && \
    apt autoremove -y && \
    apt clean -y

RUN mkdir /sbbs/

COPY startup.sh /

RUN chmod +x /startup.sh

CMD ["/startup.sh"]
