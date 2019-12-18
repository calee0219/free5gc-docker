From golang:latest

MAINTAINER Chia-An Lee <calee@cs.nctu.edu.tw>

RUN apt-get update
RUN apt-get -y install gcc cmake autoconf libtool pkg-config libmnl-dev libyaml-dev netcat tcpdump

RUN go get -u -v "github.com/sirupsen/logrus"

RUN apt-get clean

