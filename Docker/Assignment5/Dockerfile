FROM jenkins/jenkins:lts

USER root

# Install dependencies
RUN apt update \
apt install apt-transport-https ca-certificates curl software-properties-common \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" \
apt-cache policy docker-ce \
apt install docker-ce \

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
rm kubectl

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
./aws/install && \
rm -rf aws awscliv2.zip

# Allow Jenkins user to access Docker
RUN usermod -aG docker jenkins

USER jenkins
