FROM jenkins/jenkins:lts-jdk11

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

COPY jenkins_plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
COPY casc.yaml /var/jenkins_home/casc.yaml

USER root

RUN apt-get update && \
    apt-get -y install apt-utils && \
    apt-get -y install python3 && \
    apt-get -y install python3-pip

RUN curl https://get.docker.com/ > dockerinstall && chmod 777 dockerinstall && ./dockerinstall
RUN usermod -aG docker jenkins
# RUN chmod 666 /var/run/docker.sock
RUN service docker start