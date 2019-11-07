FROM ubuntu:16.04
MAINTAINER CHEN, Yuelong <yuelong.chen.btr@gmail.com>


ARG bwa_version=0.7.15
ARG samtools_version=1.9


RUN apt-get update && \
    apt-get install --yes build-essential gcc-multilib apt-utils zlib1g-dev wget git autoconf automake \
                    make gcc perl bzip2 \
                    libbz2-dev \
                    liblzma-dev libcurl4-gnutls-dev libssl-dev libncurses5-dev

RUN cd /tmp/ && \
    git clone https://github.com/lh3/bwa.git && \
    cd bwa && \
    git checkout v$bwa_version && \
    make && \
    cp -p bwa /usr/local/bin && \
    cd /tmp/ && \
    wget -c https://github.com/samtools/samtools/releases/download/$samtools_version/samtools-$samtools_version.tar.bz2 && \
    tar -jxvf samtools-$samtools_version.tar.bz2 && \
    cd samtools-$samtools_version && \
    ./configure && make && make install





# clean
RUN rm -rf /tmp/bwa /tmp/samtools && \
    apt-get clean && \
    apt-get remove --yes --purge build-essential gcc-multilib apt-utils zlib1g-dev wget



CMD bwa