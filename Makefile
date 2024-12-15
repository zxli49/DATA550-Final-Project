final_report.html: final_report.Rmd data_cleaned.rds code/04_render_final_report.R table1.rds .png
	Rscript code/04_render_final_report.R

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
	rm -f output/*.png && rm -f final_report.html && rm -f output/table1.rds && rm -f data/data_cleaned.rds

.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"

# build image
final_docker_image: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t zxli49/data550_final .
	
# build the report automatically in container
final_docker:
	docker run -v "/$(pwd)":/project zxli49/data550_final
	
 