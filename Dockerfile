FROM ubuntu:16.04

LABEL maintainer="Jaeyoung Chun (jaeyoung.chun@weizmann.ac.il)"

ENV BEAST_VERSION="v2.4.7"
ENV BEASTvntr_VERSION="v0.1.1"

RUN apt-get update -y \
    && apt-get install -y vim wget openjdk-8-jre openjdk-8-jdk gcc make autoconf automake libtool subversion pkg-config git ant unzip

WORKDIR /tmp

# install beagle-lib
RUN git clone --depth=1 https://github.com/beagle-dev/beagle-lib.git \
    && cd beagle-lib \
    && ./autogen.sh \
    && ./configure --prefix=/usr/local CPPFLAGS="-mno-avx -mno-avx2" \
    && make install

# set LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib
RUN ldconfig

# install beast2
RUN wget https://github.com/CompEvol/beast2/releases/download/${BEAST_VERSION}/BEAST.${BEAST_VERSION}.Linux.tgz \
    && tar xvzf BEAST.${BEAST_VERSION}.Linux.tgz \
    && mv beast /usr/local/bin/beast2 \
    && cp /usr/local/bin/beast2/bin/* /usr/local/bin \
    && cp /usr/local/bin/beast2/lib/* /usr/local/lib

# install BEASTvntr
RUN wget https://github.com/arjun-1/BEASTvntr/releases/download/${BEASTvntr_VERSION}/BEASTvntr.addon.${BEASTvntr_VERSION}.zip \
    && mkdir -p ~/.beast/2.4/BEASTvntr \
    && unzip BEASTvntr.addon.${BEASTvntr_VERSION}.zip -d ~/.beast/2.4/BEASTvntr

# clean up
RUN rm -rf /tmp/BEAST.${BEAST_VERSION}.Linux.tgz /tmp/BEASTvntr.addon.${BEASTvntr_VERSION}.zip

# ENTRYPOINT ["bash"]
WORKDIR /root/.beast/2.4
ENTRYPOINT ["/usr/local/bin/beauti", "-template", "/usr/local/bin/beast2/templates/Standard.xml"]
