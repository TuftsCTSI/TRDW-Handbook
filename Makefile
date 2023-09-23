preview:
	quarto preview .
clean:
	rm -rf _book
_book/trdw-handbook.pdf: index.qmd intro.qmd references.qmd summary.qmd
	quarto render --to pdf --output trdw-handbook.pdf
view: _book/trdw-handbook.pdf
	evince _book/trdw-handbook.pdf
depend:
	apt-get install librsvg2-bin
