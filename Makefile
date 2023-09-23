preview:
	quarto preview .
clean:
	rm -rf docs
docs/trdw-handbook.pdf: index.qmd intro.qmd references.qmd summary.qmd
	quarto render --to pdf --output trdw-handbook.pdf
view: docs/trdw-handbook.pdf
	evince docs/trdw-handbook.pdf
depend:
	apt-get install librsvg2-bin
