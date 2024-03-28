FROM ubuntu:jammy

RUN apt-get update && apt-get install -y git

COPY pull.sh /
RUN chmod +x pull.sh

RUN mkdir /git-autopull
VOLUME /git-autopull

CMD [ "./pull.sh" ]