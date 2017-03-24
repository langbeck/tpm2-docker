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

ENV LD_LIBRARY_PATH=/tpm2/acs:/tpm2/utils
ENV PATH=/tpm2/acs:/tpm2/utils:$PATH
WORKDIR tpm2


# IBM's TPM 2.0 TSS (version 930 required if using ACS version 898)
RUN curl -L https://sourceforge.net/projects/ibmtpm20tss/files/ibmtss930.tar |\
    tar -xz &&\
    make -C utils


# IBM's TPM 2.0 Attestation Client Server
RUN curl -L https://sourceforge.net/projects/ibmtpm20acs/files/ibmacs898.tar |\
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
