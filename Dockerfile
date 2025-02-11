FROM sigma2as/jupyterhub-singleuser-base-notebook:20231017-75e6934

LABEL maintainer="jeani@nris.no"

USER root
RUN apt update && apt install -y vim nano groff tree
COPY --chown=notebook:notebook jupyter_server_config.py /opt/.jupyter/

USER notebook
WORKDIR $HOME

COPY conda-linux-64.lock /home/notebook/conda-linux-64.lock
RUN conda create -n pangeo --file conda-linux-64.lock && \
    conda clean --all -y

RUN source activate pangeo && \
    /opt/conda/bin/ipython kernel install --user --name pangeo && \
    /opt/conda/bin/python -m ipykernel install --user --name=pangeo

COPY start-notebook.sh /home/notebook/

# Set the command to run the start-notebook.sh script
CMD ["/home/notebook/start-notebook.sh"]
