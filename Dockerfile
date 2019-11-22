FROM debian:bullseye

RUN apt update && \
    apt install -y build-essential pkg-config autoconf \
                   libnspr4-dev libssl-dev avr-libc liblhasa-dev \
                   libxbase64-dev libcap2-dev lib32ncurses-dev zip python2

ENV SBBS_STATIC_DIR=/sbbs-static/
ENV SBBSUSER=sbbs
ENV SBBSGROUP=sbbs
ENV SBBSCTRL=/sbbs/ctrl
ARG BUILD_TYPE=all

WORKDIR $SBBS_STATIC_DIR

RUN mkdir -p /sbbs/
RUN mkdir -p $SBBS_STATIC_DIR

ADD src/sbbs_src.tgz $SBBS_STATIC_DIR
ADD src/sbbs_run.tgz $SBBS_STATIC_DIR
ADD Makefile $SBBS_STATIC_DIR

RUN make -C /sbbs-static/ $BUILD_TYPE install

COPY bin/* /usr/local/sbin/
RUN chmod +x /usr/local/sbin/*

RUN rm -rf $SBBS_STATIC_DIR/src/ && \
    apt purge -y build-essential gcc dpkg-dev g++ libc-dev make \
                 pkg-config autoconf cvs && \
    apt autoremove -y && \
    apt clean -y

WORKDIR /sbbs

CMD ["sbbs"]
