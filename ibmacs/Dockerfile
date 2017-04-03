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

RUN curl -L https://sourceforge.net/projects/ibmtpm20tss/files/ibmtss974.tar.gz |\
    tar -xz &&\
    make -j4 -C utils

## END OF IBM SHARED REGION ###########



# Packages required by ACS
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
        libapache2-mod-php5 \
        libmysqlclient-dev \
        libjson0-dev \
        mysql-client \
        mysql-server \
        php5-mysql \
        apache2 \
        php5


ENV LD_LIBRARY_PATH=/tpm2/acs:$LD_LIBRARY_PATH
ENV PATH=/tpm2/acs:$PATH

# IBM's TPM 2.0 Attestation Client Server
RUN curl -L https://sourceforge.net/projects/ibmtpm20acs/files/ibmacs976.tar.gz |\
    tar -xz &&\
    mkdir -p /var/www/html/acs &&\
    chmod 777 /var/www/html/acs &&\
    make -C acs


# Configure MySQL database
RUN service mysql start &&\
    echo "create database tpm2;" | mysql &&\
    echo "grant all privileges on tpm2.* to ''@'localhost';" | mysql &&\
    mysql -D tpm2 < acs/dbinit.sql


ADD bootstrap.sh /bootstrap.sh
ENTRYPOINT ["/bootstrap.sh"]
