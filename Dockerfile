FROM alpine:edge
MAINTAINER Adrian Hobbs <adrianhobbs@gmail.com>
ENV PACKAGE "aria2 bash curl tzdata"
ARG RPC_SECRET
ENV rpc_secret=$RPC_SECRET
# Install package using --no-cache to update index and remove unwanted files
RUN apk add --no-cache $PACKAGE && \
	cp /usr/share/zoneinfo/Australia/Sydney /etc/localtime && \
	echo "Australia/Sydney" > /etc/timezone && \
	# Add a user to run as non root
	adduser -D -g '' aria2

EXPOSE 6800
USER aria2
ENV HOME /home/aria2

CMD ["/usr/bin/aria2c","--conf-path",["/home/aria2/aria2.conf","--rpc-secret","sh echo $rpc_secret"]
