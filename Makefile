
index.html:	index.Rmd
		Rscript -e 'rmarkdown::render("$^")'
		rm -f index.md
