# syntax=docker/dockerfile:1

FROM rocker/geospatial:latest

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        libcurl4-gnutls-dev \
        curl \
    && apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG=de_DE.UTF-8
RUN apt-get install -y locales && \
    sed -i -e "s/# $LANG.*/$LANG UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG

RUN install2.r --error --deps TRUE sf
RUN install2.r --error --deps TRUE formattable
RUN install2.r --error --deps TRUE kableExtra
RUN install2.r --error --deps TRUE curl
RUN install2.r --error --deps TRUE chron

RUN tlmgr update --all --self
RUN tlmgr install auxhook \
    bigintcalc \
    bitset \
    etexcmds \
    gettitlestring \
    hycolor \
    hyperref \
    intcalc \
    kvdefinekeys \
    kvsetkeys \
    ltxcmds \
    pdfescape \
    refcount \
    rerunfilecheck \
    stringenc \
    uniquecounter \
    zapfding \
    footmisc \
    koma-script \
    amsmath \
    setspace \
    iftex \
    texlive-scripts \
    xcolor \
    colortbl \
    geometry \
    booktabs \
    etoolbox \
    mdwtools \
    footnotebackref \
    letltxmacro \
    pdftexcmds \
    infwarerr \
    kvoptions \
    float \
    pagecolor \
    csquotes \
    caption \
    mdframed \
    zref \
    needspace \
    sourcesanspro \
    ly1 \
    sourcecodepro \
    titling \
    epstopdf-pkg \
    grfext \
    bookmark \
    ec \
    babel-german \
    babel-english \
    fancyhdr

RUN curl -LJO https://codeload.github.com/enhuiz/eisvogel/tar.gz/refs/tags/v1.6.1
RUN tar xzvf eisvogel-1.6.1.tar.gz && \
    mkdir -p /home/rstudio/latextemplates && \
    cp eisvogel-1.6.1/eisvogel.tex /home/rstudio/latextemplates/eisvogel.latex && \
    rm -rf eisvogel-1.6.1 eisvogel-1.6.1.tar.gz

COPY files/* /home/rstudio/
RUN mkdir /home/rstudio/output
RUN curl -o /home/rstudio/events.json https://portal.openbikesensor.hamburg/api/export/events?fmt=geojson
    
ENTRYPOINT ["/bin/sh", "/home/rstudio/entrypoint.sh"]
