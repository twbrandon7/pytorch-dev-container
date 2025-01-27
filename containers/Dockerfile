FROM nvcr.io/nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

ARG DEBIAN_FRONTEND=noninteractive

ARG PYTHON_VERSION=3.11
RUN apt-get update && apt-get install -y zsh git curl wget vim nano software-properties-common &&\
    add-apt-repository ppa:deadsnakes/ppa &&\
    apt-get update &&\
    apt-get install -y "python${PYTHON_VERSION}" "python${PYTHON_VERSION}-venv" "python${PYTHON_VERSION}-dev" &&\
    apt-get install sudo &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python${PYTHON_VERSION} 1

RUN python3 -m ensurepip 

RUN apt-get update && apt-get install ffmpeg libsm6 libxext6 -y &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 -s /bin/zsh jupyter
RUN echo "jupyter ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install Poetry
RUN pip3 install setuptools &&\
    pip3 install poetry

# Install global packages
COPY pyproject.toml /etc/python-packages/pyproject.toml
RUN cd /etc/python-packages &&\
    /bin/true &&\
    poetry config virtualenvs.create false &&\
    poetry install --no-interaction &&\
    rm -rf /root/.cache/pypoetry

USER jupyter

# Install Oh My Zsh
RUN cd /tmp && \
    curl -o install.sh -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh &&\
    sh install.sh --unattended &&\
    rm install.sh

# Install poetry plugin for Oh My Zsh
RUN mkdir -p /home/jupyter/.oh-my-zsh/plugins/poetry &&\
    /usr/local/bin/poetry completions zsh > /home/jupyter/.oh-my-zsh/plugins/poetry/_poetry

RUN echo 'export PATH="/usr/local/bin:${PATH}"' >> /home/jupyter/.zprofile
