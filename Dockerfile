FROM condaforge/miniforge3:4.10.1-0

# Install system packages
RUN apt-get update && apt-get -y install \
    build-essential cron lcov openssh-server postgresql-client redis valgrind vim libgl1-mesa-dev --no-install-recommends && \
    # Clean up
    apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/

# Force python 3.8
RUN conda install python=3.8 && conda clean -afy

# Install conda modules and do clean up
RUN conda install jupyter==1.0.0 python-graphviz==0.14 && conda clean -afy

# Install line-profiler
RUN conda install -c conda-forge line_profiler && conda clean -afy

# Install SSH server to be able to login on app service
# See: https://docs.microsoft.com/en-us/azure/app-service/configure-custom-container#enable-ssh
RUN echo "root:Docker!" | chpasswd
COPY sshd_config /etc/ssh/
EXPOSE 80 2222