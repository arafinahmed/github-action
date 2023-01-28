# Add a new comment to trigger build.
# basic nginx dockerfile starting with Ubuntu 20.04
FROM ubuntu:20.04 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
RUN apt-get -y update
RUN apt-get -y install nginx