sources := index.qmd intro.qmd references.qmd summary.qmd _quarto.yml
preview:
	quarto preview .
clean:
	rm -rf docs
docs/TRDW-Handbook.pdf: $(sources)
	quarto render --to pdf --output TRDW-Handbook.pdf
docs/TRDW-Handbook.docx: $(sources)
	quarto render --to docx --output TRDW-Handbook.docx
docx: docs/TRDW-Handbook.docx
	libreoffice docs/TRDW-Handbook.docx
view: docs/TRDW-Handbook.pdf
	evince docs/TRDW-Handbook.pdf
depend:
	apt-get install librsvg2-bin
