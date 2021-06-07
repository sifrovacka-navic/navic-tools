SH=/bin/bash
TEX=lualatex -interaction=nonstopmode
PDFTEX=pdflatex -interaction=nonstopmode

all: toolset

tools: 
	cd tools && $(MAKE)

print: front.pdf back.pdf | print.pdf

%.pdf: %.tex 
	rm -f %.xmpdata %.aux %.pdf
	$(TEX) $<
	$(TEX) $<
	
convert:
	convert -density 1200 front.pdf -resize 25% -unsharp 0x1 +append -background white -alpha remove -alpha off front.png
	convert -density 1200 back.pdf -resize 25% -unsharp 0x1 +append -background white -alpha remove -alpha off back.png
	
clean:
	rm -f *.log *.dvi *.aux *.toc *.lof *.lot *.out *.bbl *.blg *.xmpi *.nlo *.nls *.pdf *.png *.xmpdata

toolset: tools print convert

light: tools-light print convert

tools-light: 
	cd tools && $(MAKE) light

crop: back.pdf front.pdf
	$(PDFTEX) tools-back-crop.tex
	$(PDFTEX) tools-back-crop.tex
	$(PDFTEX) tools-front-crop.tex
	$(PDFTEX) tools-front-crop.tex
	pdfunite tools-front-crop.pdf tools-back-crop.pdf tools.pdf
