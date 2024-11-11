# Code Description

`code/01_data_processing.R`
- read raw data from `data/` folder
- save clean data as `.rds` in `data/` folder

`code/02_make_table.R`
- read clean data from `data/` folder
- save table 1 in `output/` folder

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
- `make clean` will remove all generated files

