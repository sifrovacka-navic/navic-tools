SH=/bin/bash
TEX=lualatex -interaction=nonstopmode
PDFTEX=pdflatex -interaction=nonstopmode

all: toolset notebook

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

toolset: tools print crop convert

light: tools-light print convert

tools-light: 
	cd tools && $(MAKE) light

crop: back.pdf front.pdf
	$(PDFTEX) tools-back-crop.tex
	$(PDFTEX) tools-back-crop.tex
	$(PDFTEX) tools-front-crop.tex
	$(PDFTEX) tools-front-crop.tex
	pdfunite tools-front-crop.pdf tools-back-crop.pdf tools.pdf

cover: notebook-cover.pdf

sheet:
	inkscape notebook-sheet.svg --export-pdf=notebook-sheet.pdf

sheet-hex:
	inkscape notebook-sheet-hex.svg --export-pdf=notebook-sheet-hex.pdf
	
%.pdf: %.tex 
	rm -f %.xmpdata %.aux %.pdf
	$(TEX) $<
	$(TEX) $<
	
cmyk:
	convert -density 1200 notebook-cover.pdf -resize 25% -unsharp 0x1 +append -background white -alpha remove -alpha off notebook-cover.png
	gs -o notebook-cover-fonts.pdf -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -c ".setpdfwrite <</NeverEmbed [ ]>> setdistillerparams" -f notebook-cover.pdf
	gs -o notebook-cover-cmyk.pdf -sDEVICE=pdfwrite -r2400 -dOverrideICC=true -sOutputICCProfile=/usr/share/color/icc/ghostscript/ps_cmyk.icc -sColorConversionStrategy=CMYK -dProcessColorModel=/DeviceCMYK -dRenderIntent=3 -dDeviceGrayToK=true -f notebook-cover-fonts.pdf
	rm notebook-cover-fonts.pdf
	gs -o notebook-sheet-grayscale.pdf -sDEVICE=pdfwrite -sProcessColorModel=DeviceGray -sColorConversionStrategy=Gray -dOverrideICC -f notebook-sheet.pdf
	gs -o notebook-sheet-hex-grayscale.pdf -sDEVICE=pdfwrite -sProcessColorModel=DeviceGray -sColorConversionStrategy=Gray -dOverrideICC -f notebook-sheet-hex.pdf

notebook: tools cover sheet sheet-hex

blok: notebook
