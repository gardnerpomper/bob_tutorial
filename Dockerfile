FROM centos:6.6
MAINTAINER "Gardner Pomper" gardner@networknow.org
RUN yum -y update && yum clean all
RUN yum -y install \
    gcc		\
    make	\
    sudo	\
    tcsh	\
    && yum clean all
#
RUN groupadd dev && \
    useradd dev -g dev -G dev,wheel
#
# Enable passwordless sudo for users under the "sudo" group
#
RUN echo "%wheel	ALL=(ALL)	NOPASSWD: ALL" >> /etc/sudoers
#
VOLUME vol
WORKDIR vol

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["tail","-f", "/dev/null"]
