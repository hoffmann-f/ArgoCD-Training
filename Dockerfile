FROM ubuntu:jammy

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
RUN apt-get update
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

RUN curl -L "https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
RUN curl -L "https://kind.sigs.k8s.io/dl/v0.20.0/kind-$(uname)-amd64" -o /usr/local/bin/kind
RUN chmod +x /usr/local/bin/kind
COPY kind-config.yaml /root/
ENTRYPOINT kind create cluster --config=/root/kind-config.yaml --name=argo-cd-test-cluster; /bin/bash