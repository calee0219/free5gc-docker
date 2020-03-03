From golang:latest
ENV GO111MODULE=on
ENV GOPATH="/:${GOPATH}"
WORKDIR /gofree5gc

MAINTAINER Chia-An Lee <calee@cs.nctu.edu.tw>

RUN apt-get update
RUN apt-get -y install gcc cmake autoconf libtool pkg-config libmnl-dev libyaml-dev netcat tcpdump

RUN go get -u -v "github.com/sirupsen/logrus"

RUN apt-get clean

