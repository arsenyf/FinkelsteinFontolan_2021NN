# DataJoint pipeline for Finkelstein, Fontolan et al. "Attractor dynamics gate cortical information flow during decision-making", 2021

This repository houses the data analysis code accompanying the following publication: 

Finkelstein, Fontolan et al. "Attractor dynamics gate cortical information flow during decision-making", 2021

The pipeline for data analysis is in [DataJoint](https://datajoint.io/) framework. For users interested in recreating this pipeline, import data and reproduce the analysis results, 
please see the instruction below.

# Initialize the pipeline

Follow the instruction here to:

1. Create a MySQL database server in a Docker container

2. Initialize the DataJoint pipeline (e.g. schemas and tables) in the said database

3. Populate the database with data related to the publication (data published separately in NWB format)

5. Access the data via DataJoint framework with MATLAB or Python


## Prerequisite

+ Have [Docker](https://www.docker.com/products/docker-desktop) installed on your computer

+ Have [DataJoint-MATLAB](https://docs.datajoint.io/matlab/setup/01-Install-and-Connect.html) package installed


## Step 1: Clone the repository
Navigate to a new folder directory for this project. Then clone this repository (`publication_ready` branch) by typing the following in the Command Prompt
    
    
    git clone --single-branch -b publication_ready https://github.com/arsenyf/FinkelsteinFontolan_2021NN
    

Change your working directory to the `FinkelsteinFontolan_2021NN` folder


    cd FinkelsteinFontolan_2021NN


## Step 2: Setup `dj_local_conf.json`
The provided template configuration file `template_dj_local_conf.json` is sufficient. 
Rename `template_dj_local_conf.json` to `dj_local_conf.json`

(Advanced users are welcome to make any modifications as needed)

## Step 3: Download the NWB files

NWB files with extracellular electrophysioligical recordings are available here:
https://gui.dandiarchive.org/#/dandiset/000060


Create a new folder named ***nwb_data*** in this ***DJ_S1ALM*** working directory 

Download data in NWB format, and place those NWB files in the created ***nwb_data*** folder


## Step 4: Run `docker-compose up`
Build the Docker images (one time)

    docker-compose build --no-cache

Launch the containers:
    
    docker-compose up -d
    
When finished, you can stop the containers:

    docker-compose down
    
Note: a new ***db_data*** folder will be created, and the data for MySQL database is stored in this ***db_data*** folder, this folder is persistent.
To resume working with this pipeline, you will only need to `docker-compose up` again


Note that for Steps 5-6, the Command Promt should remain open

## Step 5: Launch MATLAB and run `init.m`

Restart MATLAB to ensure no previous DataJoint connections are open. Ensure ***FinkelsteinFontolan_2021NN*** is your "Current Folder" in MATLAB

On the Command Window (in MATLAB), run


    init
    
    
To rerun the ingestion progress check, run


    get_ingestion_progress()
    
    
## Step 6: Go to MATLAB and explore the data

Ensure ***FinkelsteinFontolan_2021NN*** is your "Current Folder" in MATLAB.
Explore the data. For example, to inspect the Session table, try:

    
    EXP.Session()

    
## OR Step 6: Go to Jupyter notebook and explore the data
The password to connect is ***datajoint***

Create any new notebooks in the ***dja*** folder

To connect to the pipeline, see the sample code below
    
    
    import os
    os.chdir('/main')
    
    from pipeline_py.nwb_to_datajoint import *
    
    experiment.Session()
    
