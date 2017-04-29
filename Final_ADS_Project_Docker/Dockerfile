
FROM debian:testing

MAINTAINER Sweta Bajaj

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN useradd docker \
	&& mkdir /home/docker \
	&& chown docker:docker /home/docker \
	&& addgroup docker staff

RUN apt-get update \ 
	&& apt-get install -y --no-install-recommends \
		ed \
		less \
		locales \
		vim-tiny \
		wget \
		ca-certificates \
		fonts-texgyre \
	&& rm -rf /var/lib/apt/lists/*



RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    python-pip --upgrade python-pip \
    git mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.3.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

## Use Debian unstable via pinning -- new style via APT::Default-Release
RUN echo "deb http://http.debian.net/debian sid main" > /etc/apt/sources.list.d/debian-unstable.list \
	&& echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/default


ENV PATH /opt/conda/bin:$PATH

RUN pip install luigi
ADD Upload_To_S3.py Upload_To_S3.py
ADD MetaData_For_Training.py MetaData_For_Training.py
ADD Download_OutBrain_Data.py Download_OutBrain_Data.py
ADD Outbrain_luigi_Script.py Outbrain_luigi_Script.py
ADD Upload_To_S3.py Upload_To_S3.py
ADD xgboost.pkl xgboost.pkl
ADD TestData.csv TestData.csv
ADD Predicted_Output.py Predicted_Output.py

#ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD /bin/bash -c 'jupyter notebook --ip=* --NotebookApp.password="$PASSWD" "$@"'
