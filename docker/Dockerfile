FROM quay.io/jupyter/minimal-notebook:notebook-7.4.2

USER root

RUN apt update

RUN apt install -y openjdk-21-jdk maven git make graphviz plotutils ghostscript libglib2.0-bin

USER jovyan

RUN pip install graphviz

RUN pip install jupytext

RUN git clone https://github.com/Misrobody/OtktSurvey.git --recurse-submodules --branch main --depth 1

RUN rm -r work

WORKDIR OtktSurvey

RUN jupytext --to notebook INSTRUCTIONS.md
