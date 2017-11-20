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


ENV PATH=/tpm2/src:$PATH
WORKDIR tpm2


# IBM's Software TPM 2.0
RUN curl -L https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm974.tar.gz |\
    tar -xz &&\
    make -j4 -C src


## END OF SHARED REGION ###############



## BEGIN OF IBM SHARED REGION #########

ENV LD_LIBRARY_PATH=/tpm2/utils:$LD_LIBRARY_PATH
ENV PATH=/tpm2/utils:$PATH

RUN curl -L https://sourceforge.net/projects/ibmtpm20tss/files/ibmtss996.tar.gz |\
    tar -xz &&\
    make -j4 -C utils

## END OF IBM SHARED REGION ###########



ADD bootstrap.sh /bootstrap.sh
ENTRYPOINT ["/bootstrap.sh"]
