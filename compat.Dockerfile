ARG base
FROM ${base}

ARG base
RUN echo "Creating compat stack based off of ${base}"
ARG packages
ARG package_args='--allow-downgrades --allow-remove-essential --allow-change-held-packages --no-install-recommends'

RUN echo "debconf debconf/frontend select noninteractive" | debconf-set-selections && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get -y $package_args update && \
  apt-get -y $package_args install $packages && \
  apt-get clean && \
  find /usr/share/doc/*/* ! -name copyright | xargs rm -rf
