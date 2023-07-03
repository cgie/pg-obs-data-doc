## Openbikesensor data report Dockerfile

This repository contains a **Dockerfile** to automatically generate a data evaluation document for the [ADFC HH](https://hamburg.adfc.de/)'s Openbikesensor [portal](https://portal.openbikesensor.hamburg/).


### Base Docker Image

* [rocker/geospatial](https://rocker-project.org)


### Docker Tags

none yet


### Installation

1. Install [Docker](https://www.docker.com/).

2. Build an image from Dockerfile: `docker build -t="adfc/pgobs/datadoc" .`)


### Usage

```shell
function _docker_obs_run () {
    output_dir="$(pwd)/obsdata_$(date +"obs_doc_%Y_%m_%d_%H_%M_%S")"
    mkdir -p ${output_dir}
    docker run --rm -ti \
        -v "${output_dir}:/home/rstudio/output" \
        adfc/pgobs/datadoc:latest
}

function _docker_obs_run_dev () {
    docker run --rm -ti -p 8787:8787 \
        -e PASSWORD=statesman \
        -v "/home/cgie/docker/files/:/home/rstudio/" \
        --entrypoint=/bin/bash \
        adfc/pgobs/datadoc:latest \
        /init
}

alias dobs='_docker_obs_run'
alias dobsdev='_docker_obs_run_dev'
```
