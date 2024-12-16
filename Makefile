final_report.html: final_report.Rmd data_cleaned.rds code/04_render_final_report.R table1.rds .png
	Rscript code/04_render_final_report.R && mv final_report.html report

# creates cleaned data
data_cleaned.rds: code/01_data_processing.R
	Rscript code/01_data_processing.R

# creates table 1
table1.rds: code/02_make_table.R
	Rscript code/02_make_table.R

# creates figures
.png: code/03_make_figures.R data_cleaned.rds
	Rscript code/03_make_figures.R

.PHONY: clean
clean:
	rm -f output/*.png && rm -f report/final_report.html && rm -f output/table1.rds && rm -f data/data_cleaned.rds

.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"


# build image
PROJECTFILES = final_report.Rmd code/01_data_processing.R code/02_make_table.R code/03_make_figures.R code/04_render_final_report.R Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json

build: $(PROJECTFILES) $(RENVFILES)
	docker build -t zxli49/data550-final:latest .
	touch $@
	
# build the report automatically in container
docker_run_mac: 
	docker run -v "$$(pwd)/report":/project/report zxli49/data550-final:latest
	
docker_run_win: 
	docker run -v /"$$(pwd)/report":/project/report zxli49/data550-final:latest


 