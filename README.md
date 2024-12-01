# DATA550 Final Project Repository

## Synchronize Package Repository and Generate Final Report

1. Ensure you have RStudio installed on your system.
2. Clone this repository to your local machine.
3. Make sure package `renv` is installed and the project environment is activated.
4. Run the command `make install` in the terminal to synchronize the package repository.
5. Run the command `make final_report.html` in the terminal.

## Code Description

`code/01_data_processing.R`
- read raw data from `data/` folder
- save clean data as `.rds` in `data/` folder

`code/02_make_table.R`
- read clean data from `data/` folder
- save descriptive summary table 1 in `output/` folder

`code/03_make_figures.R`
- read clean data from `data/` folder
- save box plot and bar plot in `output/` folder

`code/04_render_final_report.R`
- render `final_report.Rmd` 
- save compiled report

`final_report.Rmd`
- read data, table, and figures from respective locations
- display results for production report

`Makefile`
- contains rules for building the final report
- `make data_cleaned.rds` will save the cleaned data in `data/` folder
- `make table1.rds` will generate a descriptive summary table needed to compile the report
- `make .png` will generate 2 figures needed to compile the report
- `make final_report.html` generates the final report in `.html` format.
- `make clean` will remove all generated files

