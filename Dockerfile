FROM rocker/rstudio:4.5.1

# FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04
ENV RENV_VER='1.0.11'
ARG ROOT=$ROOT

ENV QUARTO_VERSION='1.7.32'
ARG QUARTO_ARCH=$QUARTO_ARCH


# update packages and install dependencies
RUN apt-get -qq update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq -y install --no-install-recommends \
    build-essential gfortran libglpk40 \
    zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev \
    liblzma-dev libbz2-dev \
    libssl-dev libreadline-dev libffi-dev \
    wget xorg openbox rclone git gh \
    curl libcurl4-openssl-dev

# install AWS dependencies
RUN apt-get -qq -y install s3fs
RUN curl --silent "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && sudo ./aws/install && rm -f awscliv2.zip

# install python dependencies
RUN apt-get -qq -y install pkg-config python3-venv python3-dev

# instal quarto
RUN wget --quiet -O quarto.deb https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-${QUARTO_ARCH}.deb \
          && sudo dpkg -i quarto.deb

# install R package renv
# See Ubuntu repos for more packages that can be installed through apt manager: https://cloud.r-project.org/bin/linux/ubuntu/
RUN Rscript -e "install.packages('remotes', repos='https://cloud.r-project.org', verbose='TRUE'); remotes::install_version('renv', version = '$RENV_VER')"

# create working dir and update rstudio user/group
WORKDIR /home/rstudio
RUN bash /rocker_scripts/init_userconf.sh

