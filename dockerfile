FROM ubuntu:18.04
RUN apt update && apt install software-properties-common -y && add-apt-repository ppa:ondrej/php -y && apt update 
ARG phpv
ARG xdebug
ENV DEBIAN_FRONTEND noninteractive
RUN echo -e "1\n1\n"|apt install $phpv -y --force-yes 
RUN if [ "$xdebug" = "yes" ] ; then apt install ${phpv}-xdebug ;fi
CMD ["/bin/bash"]

