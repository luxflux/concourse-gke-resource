FROM google/cloud-sdk

RUN apt-get install -y --no-install-recommends jq gettext-base && rm -rf /var/lib/apt/lists/*

ADD bin/check /opt/resource/check
ADD bin/in /opt/resource/in
ADD bin/out /opt/resource/out
