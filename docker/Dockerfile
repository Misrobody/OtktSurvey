FROM quay.io/jupyter/minimal-notebook:notebook-7.4.2

USER root

# Set timezone inside container
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

# Install necessary packages
RUN apt update && \
    apt install -y openjdk-21-jdk maven git

RUN pip install graphviz

RUN pip install jupytext

RUN git clone https://github.com/Misrobody/OtktSurvey.git --recurse-submodules --branch main --depth 1

RUN rm -r work

WORKDIR OtktSurvey

RUN jupytext --to notebook INSTRUCTIONS.md
