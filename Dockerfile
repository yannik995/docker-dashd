FROM phusion/baseimage

ARG USER_ID
ARG GROUP_ID

ENV HOME /pivx

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} pivx
RUN useradd -u ${USER_ID} -g pivx -s /bin/bash -m -d ${HOME} pivx

RUN chown pivx:pivx -R /pivx

ADD https://github.com/PIVX-Project/PIVX/releases/download/v3.0.6/pivx-3.0.6-x86_64-linux-gnu.tar.gz /tmp/
RUN tar -xvf /tmp/pivx-*.tar.gz -C /tmp/
RUN cp /tmp/pivx*/bin/*  /usr/local/bin
RUN rm -rf /tmp/pivx*

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.
USER pivx

VOLUME ["/pivx"]

EXPOSE 51472 51473 51474 51475

WORKDIR /pivx

CMD ["pivx_oneshot"]
