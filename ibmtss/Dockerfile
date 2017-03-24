## BEGIN OF SHARED REGION #############
FROM ubuntu:trusty

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



## BEGIN OF IBM SHARED REGION #########

# IBM's TPM 2.0 TSS (version 930 required if using ACS version 898)
RUN curl -L https://sourceforge.net/projects/ibmtpm20tss/files/ibmtss930.tar |\
    tar -xz &&\
    make -j4 -C utils

## END OF IBM SHARED REGION ###########


ENV LD_LIBRARY_PATH=/tpm2/utils:/tpm2/src
ENV PATH=/tpm2/utils:/tpm2/src:$PATH


ADD bootstrap.sh /bootstrap.sh
ENTRYPOINT ["/bootstrap.sh"]
