From golang:1.12.9-stretch AS builder

MAINTAINER Chia-An Lee <calee@cs.nctu.edu.tw>

ENV GO111MODULE=off

RUN apt-get update
RUN apt-get -y install gcc cmake autoconf libtool pkg-config libmnl-dev libyaml-dev
RUN apt-get clean

# Get Free5GC
RUN cd $GOPATH/src \
    && git clone https://github.com/free5gc/free5gc.git \
    && cd free5gc \
    && git submodule update --init \
    && ./install_env.sh

# Build NF (AMF, AUSF, N3IWF, NRF, NSSF, PCF, SMF, UDM, UDR)
RUN cd $GOPATH/src/free5gc/src \
    && for d in * ; do if [ -f "$d/$d.go" ] ; then go build -o ../bin/"$d" -x "$d/$d.go" ; fi ; done ;

# Build UPF
#RUN go get -u -v "github.com/sirupsen/logrus"
RUN cd $GOPATH/src/free5gc/src/upf \
    && mkdir -p build \
    && cd build \
    && cmake .. \
    && make -j `nproc`

FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -y install netcat tcpdump iproute2
RUN apt-get clean

WORKDIR /root/free5gc
# Copy AMF, AUSF, N3IWF, NRF, NSSF, PCF, SMF, UDM, UDR
COPY --from=builder /go/src/free5gc/bin/* ./
# Copy UPF
COPY --from=builder /go/src/free5gc/src/upf/build/bin/* ./
# Copy pem key
RUN mkdir -p ../support/TLS
COPY --from=builder /go/src/free5gc/support/TLS/* ../support/TLS/
# Copy log key
RUN mkdir -p ../config
COPY --from=builder /go/src/free5gc/config/free5GC.conf ../config

