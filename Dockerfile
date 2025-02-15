from jenkins/jenkins:lts

USER root

# Node.js
# We need to use a later version of Node than is currently available in the Ubuntu package manager (2015-06-17)
# deprecated RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
 
# Install git, maven, default-jdk, nodejs
# The tar and bzip2 packages are required for Phantom.js installation in npm: https://github.com/Medium/phantomjs/issues/326
RUN \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
    curl \
    bzip2 \
    traceroute \
    dnsutils \
    tcpdump \
    telnet \
    git \
    maven \
    nodejs \
    ansible \
    awscli
    
RUN \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

RUN \
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - && \
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"

RUN \
  apt-get clean && \
  apt-get update && \
  apt-get install -y \
    docker-ce

# Install Docker (to be used as a client only)
# RUN wget -qO- https://get.docker.com/ | sh
RUN usermod -aG docker jenkins

USER jenkins

# Add Git plugin
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
