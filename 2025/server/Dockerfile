FROM ubuntu:22.04
RUN apt-get update -y && \
    apt-get dist-upgrade -y && \
    apt-get install -y curl && \
    apt-get autoclean -y && \
    apt-get autoremove -y
COPY ./Linux64/Debug/ /usr/sbin
ARG PORT=9050
EXPOSE $PORT
ENTRYPOINT ["/usr/sbin/docker_example_server"]

# To create a docker image
# docker build -t ownerigor/docker-horse .

# To create a container
# docker run -p 9050:9050 -d ownerigor/docker-horse