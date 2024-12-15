# Base image
FROM rocker/r-ubuntu AS base

# Install R 4.4.2
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9 && \
    add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/" && \
    apt-get update && \
    apt-get install -y r-base=4.4.2-1.2204.0 && \
    apt-get clean
    
# Install renv globally
RUN R -e "install.packages('renv', repos = 'https://cran.rstudio.com')"

# create a directory in the image
WORKDIR /project

# Create working directory and renv folder
RUN mkdir -p renv
COPY renv.lock renv.lock
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

# change the default location of the renv cache to be in project directory
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache

# Restore the renv package library
RUN R -e "renv::restore()"

# copy files and create folders    
COPY Makefile final_report.Rmd /project/
RUN mkdir -p /project/code /project/output /project/data
COPY data/Sleep_health_and_lifestyle_dataset.csv /project/data/

COPY code /project/code

# intall pandoc
RUN apt-get update && apt-get install -y \
    pandoc \
    pandoc-citeproc \
    && apt-get clean
    
# install missing package
RUN R -e "install.packages('cardx')"

CMD ["make"]
