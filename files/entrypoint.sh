#!/bin/sh

echo "Generating pdf"

cd /home/rstudio/

output_file="$(date +"adfc_hh_obs_doc_%Y_%m_%d_-_%I_%M_%p").pdf"

Rscript -e "rmarkdown::render('rdok.Rmd', output_file='${output_file}', output_dir='/home/rstudio/output')"

echo "Generating pdf… finished"
