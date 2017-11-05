FROM ubuntu:16.04

LABEL maintainer="Jaeyoung Chun (jaeyoung.chun@weizmann.ac.il)"

RUN apt-get update -y \
    && apt-get install -y vim wget openjdk-8-jre openjdk-8-jdk gcc make autoconf automake libtool subversion pkg-config git ant

WORKDIR /tmp

# install beagle-lib
RUN git clone --depth=1 https://github.com/beagle-dev/beagle-lib.git \
    && cd beagle-lib \
    && ./autogen.sh \
    && ./configure --prefix=/usr/local CPPFLAGS="-mno-avx -mno-avx2" \
    && make install

ENV LD_LIBRARY_PATH=/usr/local/lib

# install beast2
RUN git clone https://github.com/CompEvol/beast2.git
RUN cd beast2 \
    && ant

# install BEASTvntr
RUN git clone https://github.com/arjun-1/BEASTvntr.git
RUN cd BEASTvntr \
    && ant addon

RUN mkdir -p ~/.beast/2.4/BEASTvntr \
    && cp -r /tmp/BEASTvntr/release/add-on ~/.beast/2.4/BEASTvntr

# RUN cp beast/bin/* /usr/local/bin
# RUN cp beast/lib/* /usr/local/lib

ENTRYPOINT ["bash"]
