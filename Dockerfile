FROM condaforge/miniforge3:4.12.0-2

# Install system packages
RUN apt-get update && apt-get -y install \
    build-essential cron lcov openssh-server postgresql-client redis valgrind vim libgl1-mesa-dev libpq-dev logrotate --no-install-recommends && \
    # Clean up
    apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/

# Force python 3.10
RUN conda install python=3.10 && conda clean -afy

# Install conda modules and do clean up
RUN conda install jupyter==1.0.0 python-graphviz==0.20 nodejs==17.9.0 && conda clean -afy

# Install line-profiler
RUN conda install -c conda-forge line_profiler && conda clean -afy

# Install datadog
COPY install_dd.sh install_dd.sh
RUN chmod u+x install_dd.sh && DD_API_KEY=placeholder DD_AGENT_MAJOR_VERSION=7 ./install_dd.sh
RUN rm -rf /etc/datadog-agent/datadog.yaml

# Install SSH server to be able to login on app service
# See: https://docs.microsoft.com/en-us/azure/app-service/configure-custom-container#enable-ssh
RUN echo "root:Docker!" | chpasswd
COPY sshd_config /etc/ssh/
EXPOSE 80 2222