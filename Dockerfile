FROM gcr.io/kaggle-images/python:latest

WORKDIR /app

COPY ./requirements.txt /app

# Install Mecab
RUN apt-get update \
    && apt-get install -y mecab \
    && apt-get install -y libmecab-dev \
    && apt-get install -y mecab-ipadic-utf8 \
    && apt-get install -y git \
    && apt-get install -y make \
    && apt-get install -y curl \
    && apt-get install -y xz-utils \
    && apt-get install -y file \
    && apt-get install -y sudo \
    && apt-get install -y wget \
    && apt-get install -y software-properties-common vim
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git \
    && cd mecab-ipadic-neologd \
    && bin/install-mecab-ipadic-neologd -n -y

# Upgraade pip
RUN pip install -U pip

# Install libraries
RUN pip install -r /app/requirements.txt 


### ========================== Install nvm ==========================
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# make sure apt is up to date
RUN apt-get update --fix-missing
RUN apt-get install -y curl
RUN apt-get install -y build-essential libssl-dev

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 12.12.0

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

WORKDIR /app

### ========================== Install jupyterlab extensions ==========================
RUN jupyter labextension install jupyterlab_vim
RUN jupyter labextension install @jupyterlab/toc
RUN pip install 'python-language-server[all]' 
RUN pip install --pre jupyter-lsp 
RUN jupyter labextension install @krassowski/jupyterlab-lsp
RUN jupyter labextension install @lckr/jupyterlab_variableinspector
RUN jupyter labextension install @ryantam626/jupyterlab_code_formatter
RUN jupyter labextension install @jupyterlab/git
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
RUN jupyter labextension install jupyterlab-flake8
RUN jupyter labextension install @jupyterlab/plotly-extension
RUN jupyter labextension install jupyterlab_bokeh