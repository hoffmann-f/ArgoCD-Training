FROM docker:24.0.7-dind

RUN apk update
RUN apk upgrade
RUN apk add curl
RUN apk add vim

RUN curl -L "https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl
RUN curl -L "https://kind.sigs.k8s.io/dl/v0.20.0/kind-$(uname)-amd64" -o /usr/local/bin/kind
RUN chmod +x /usr/local/bin/kind
COPY kind-config.yaml /root/

RUN curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
RUN install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
RUN rm argocd-linux-amd64

RUN apk add k9s

RUN mkdir /workingdir
RUN mkdir /workingdir/task1

COPY install.yaml /install.yaml
EXPOSE 8080/tcp

ENTRYPOINT kind create cluster --config=/root/kind-config.yaml --name=argo-cd-test-cluster; sh