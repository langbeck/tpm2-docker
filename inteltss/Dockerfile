## BEGIN OF SHARED REGION #############
FROM ubuntu:trusty

ARG https_proxy
ARG http_proxy

# NOTE: This is a common layer shared with some Dockerfile's
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        libssl-dev \
        curl \
        make \
        gcc \
        vim


WORKDIR tpm2


# IBM's Software TPM 2.0
RUN curl -L https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm974.tar.gz |\
    tar -xz &&\
    make -j4 -C src


## END OF SHARED REGION ###############


# Packages required by Intel projects
RUN apt-get install -y --no-install-recommends \
        libcurl4-openssl-dev \
        autoconf-archive \
        pkg-config \
        autoconf \
        automake \
        libtool \
        curl \
        man \
        git


RUN git clone https://github.com/01org/TPM2.0-TSS &&\
    cd TPM2.0-TSS &&\
    ./bootstrap &&\
    ./configure --prefix=/usr &&\
    make -j4 &&\
    make install

RUN git clone https://github.com/01org/tpm2.0-tools &&\
    cd tpm2.0-tools &&\
    ./bootstrap &&\
    ./configure --prefix=/usr &&\
    make -j4 &&\
    make install

ENV PATH=/tpm2/src:$PATH

ADD bootstrap.sh /bootstrap.sh
ENTRYPOINT ["/bootstrap.sh"]
