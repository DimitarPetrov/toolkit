FROM ubuntu:18.04 AS package_step

ENV GIT_SSL_NO_VERIFY true

RUN apt-get update && \
  apt-get install -y python3-dev && \
  apt-get install -y cmake && \
  apt-get install -y curl && \
  apt-get install -y git && \
  apt-get install -y vim && \
  apt-get install -y postgresql-client && \
  apt-get install -y jq && \
  apt-get install -y ruby-full && \
  apt-get install -y build-essential && \
  apt-get install -y zsh && \
  apt-get install -y fonts-powerline && \
  apt-get install -y docker.io

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# copy dotfiles
COPY ".bashrc" ".vimrc" ".zshrc" ".fzf.zsh" "/root/"
COPY ".oh-my-zsh" "/root/.oh-my-zsh"
COPY ".z" "/root/.z"
COPY ".vim" "/root/.vim"

# setup vim plugins
RUN cd ${HOME}/.vim/bundle/YouCompleteMe && python3 install.py && vim +PlugInstall +qall

# install fzf
RUN  git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf && ${HOME}/.fzf/install

# install uaac
RUN gem install cf-uaac

# install CF cli
RUN curl -s https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - && \
  echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
  apt-get update && \
  apt-get install -y cf-cli

# install kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
  apt-get update && \
  apt-get install -y kubectl

# install svcat
RUN curl -sLO https://download.svcat.sh/cli/latest/linux/amd64/svcat && \
  chmod +x ./svcat && \
  mv ./svcat /usr/bin/

# install helm
RUN curl -s https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh && \
  chmod +x get_helm.sh && \
  ./get_helm.sh

ARG SMCTL_VERSION=v1.10.4
# install smctl
RUN curl -sL -o smctl https://github.com/Peripli/service-manager-cli/releases/download/$SMCTL_VERSION/smctl_linux_x86-64 && \
  chmod +x smctl && \
  mv ./smctl /usr/bin/

# Check if everything is available
RUN zsh --version && echo === && \ 
  cf version && echo === && \
  kubectl version --client && echo === && \
  svcat version --client && echo === && \
  helm version --client && echo === && \
  smctl version && echo === 

CMD zsh
