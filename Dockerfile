ARG distro
ARG version

FROM ${distro}:${version}

# Install distcc
RUN apt-get update && \
	apt-get dist-upgrade -yq && \
	apt-get install -yq g++ clang distcc ccache && \
	apt-get autoremove -yq && \
	apt-get autoclean && \
	rm -fr /tmp/* /var/lib/apt/lists/*

# Create a new user named 'user'
RUN useradd --create-home --shell /bin/sh user
USER user

EXPOSE 3632
ENTRYPOINT ["distccd", "--daemon", "--no-detach", "--log-stderr", "--log-level=debug", "--allow"]
