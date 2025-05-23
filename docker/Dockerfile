FROM quay.io/jupyter/minimal-notebook:notebook-7.4.2

USER root

# Set timezone inside container
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

# Install necessary packages
RUN apt update && \
    apt install -y openjdk-21-jdk maven plotutils graphviz ghostscript git

RUN pip install graphviz

RUN pip install jupytext

RUN pip install --no-deps kieker-for-jupyter

RUN git clone https://github.com/Misrobody/OtktSurvey.git --recurse-submodules --branch main --depth 1

RUN rm work

RUN cd OtktSurvey

RUN jupytext --to notebook INSTRUCTIONS.md


