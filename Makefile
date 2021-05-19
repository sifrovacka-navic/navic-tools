SH=/bin/bash
TEX=lualatex -interaction=nonstopmode

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
