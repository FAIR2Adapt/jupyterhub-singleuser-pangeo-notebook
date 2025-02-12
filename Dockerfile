FROM sigma2as/jupyterhub-singleuser:20240301-21d3e39

LABEL maintainer="annef@simula.no"

USER root
RUN apt update && apt install -y vim nano groff tree
COPY --chown=notebook:notebook jupyter_server_config.py /opt/.jupyter/

USER notebook

COPY conda-linux-64.lock /home/notebook/conda-linux-64.lock
RUN conda create -n pangeo --file conda-linux-64.lock && \
    conda clean --all -y

RUN /opt/conda/envs/pangeo/bin/python -m ipykernel install --name pangeo --prefix /opt/conda

USER notebook
