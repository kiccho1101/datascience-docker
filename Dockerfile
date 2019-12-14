FROM gcr.io/kaggle-images/python:latest

ADD ./bert /app/bert
ADD ./jumanpp-2.0.0-rc2 /app/jumanpp-2.0.0-rc2
ADD ./notebook /app/notebook
ADD ./src /app/src
ADD ./requirements.txt /app

### ============================ Install Juman++ ============================
WORKDIR /app/jumanpp-2.0.0-rc2/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local
RUN make
RUN make install 

### ============================ Install Mecab ============================
WORKDIR /app
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

### ========================== Install nvm (for jupyterlab) ==========================
WORKDIR /app

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Make sure apt is up to date
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


### ============================ Install python modules ============================
WORKDIR /app

# Install dependencies
RUN pip install -U pip
RUN pip install -r /app/requirements.txt

# Install jupyterlab
RUN pip install jupyterlab \
    && jupyter serverextension enable --py jupyterlab

# Install Jupyter Notebook Extensions
RUN jupyter contrib nbextension install --user \
    && jupyter nbextensions_configurator enable --user

# Install Jupyter Black
RUN jupyter nbextension install https://github.com/drillan/jupyter-black/archive/master.zip --user \
    && jupyter nbextension enable jupyter-black-master/jupyter-black

# Install Jupyter Isort
RUN jupyter nbextension install https://github.com/benjaminabel/jupyter-isort/archive/master.zip --user \
    && jupyter nbextension enable jupyter-isort-master/jupyter-isort

# Enable Nbextensions (Reference URL: https://qiita.com/simonritchie/items/88161c806197a0b84174)
RUN jupyter nbextension enable table_beautifier/main \
    && jupyter nbextension enable toc2/main \
    && jupyter nbextension enable toggle_all_line_numbers/main \
    && jupyter nbextension enable autosavetime/main \
    && jupyter nbextension enable collapsible_headings/main \
    && jupyter nbextension enable execute_time/ExecuteTime \
    && jupyter nbextension enable codefolding/main \
    && jupyter nbextension enable varInspector/main \
    && jupyter nbextension enable notify/notify 

# Setup jupyter-vim
RUN mkdir -p $(jupyter --data-dir)/nbextensions \
    && cd $(jupyter --data-dir)/nbextensions \
    && git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding \
    && jupyter nbextension enable vim_binding/vim_binding

# Change Theme
RUN jt -t chesterish -T -f roboto -fs 9 -tf merriserif -tfs 11 -nf ptsans -nfs 11 -dfs 8 -ofs 8 -cellw 99% \
    && sed -i '1s/^/.edit_mode .cell.selected .CodeMirror-focused:not(.cm-fat-cursor) { background-color: #1a0000 !important; }\n /' /root/.jupyter/custom/custom.css \
    && sed -i '1s/^/.edit_mode .cell.selected .CodeMirror-focused.cm-fat-cursor { background-color: #1a0000 !important; }\n /' /root/.jupyter/custom/custom.css

# ### ========================== Install jupyterlab extensions ==========================
# RUN jupyter labextension install jupyterlab_vim
# RUN jupyter labextension install @jupyterlab/toc
# RUN pip install 'python-language-server[all]' 
# RUN pip install --pre jupyter-lsp 
# RUN jupyter labextension install @krassowski/jupyterlab-lsp
# RUN jupyter labextension install @lckr/jupyterlab_variableinspector
# RUN jupyter labextension install @ryantam626/jupyterlab_code_formatter
# RUN jupyter labextension install @jupyterlab/git
# RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager
# RUN jupyter labextension install jupyterlab-flake8
# RUN jupyter labextension install @jupyterlab/plotly-extension
# RUN jupyter labextension install jupyterlab_bokeh