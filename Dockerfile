FROM sigma2as/jupyterhub-singleuser:20240301-21d3e39

LABEL maintainer="annef@simula.no"
# Install system packages
USER root
RUN apt update && apt install -y vim nano groff tree

# Install other packages
USER notebook
COPY conda-linux-64.lock /home/notebook/conda-linux-64.lock
RUN conda create -n pangeo --file conda-linux-64.lock

RUN source activate pangeo && \
    /opt/conda/bin/ipython kernel install --user --name pangeo && \
    /opt/conda/bin/python -m ipykernel install --user --name=pangeo


# Fix hub failure
#RUN fix-permissions $HOME

# Install other packages
USER notebook
