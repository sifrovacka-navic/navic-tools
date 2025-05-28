SH=/bin/bash
TEX=lualatex -interaction=nonstopmode
PDFTEX=pdflatex -interaction=nonstopmode

all: toolset notebook

tools-src: 
	cd tools && $(MAKE)

tools: tools-front.pdf tools-back.pdf | tools-print.pdf
	pdfunite tools-front.pdf tools-back.pdf tools.pdf

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

tools-crop: tools-back.pdf tools-front.pdf
	$(PDFTEX) tools-back-crop.tex
	$(PDFTEX) tools-back-crop.tex
	$(PDFTEX) tools-front-crop.tex
	$(PDFTEX) tools-front-crop.tex
	pdfunite tools-front-crop.pdf tools-back-crop.pdf tools-crop.pdf


tools-wide-crop: tools-wide-back.pdf tools-wide-front.pdf
	$(PDFTEX) tools-wide-back-crop.tex
	$(PDFTEX) tools-wide-back-crop.tex
	$(PDFTEX) tools-wide-front-crop.tex
	$(PDFTEX) tools-wide-front-crop.tex
	pdfunite tools-wide-front-crop.pdf tools-wide-back-crop.pdf tools-crop.pdf

cover: notebook-cover.pdf

sheet:
	inkscape notebook-sheet.svg --export-type=pdf --export-filename=notebook-sheet.pdf

sheet-hex:
	inkscape notebook-sheet-hex.svg --export-type=pdf --export-filename=notebook-sheet-hex.pdf
	inkscape notebook-sheet-trihex.svg --export-type=pdf --export-filename=notebook-sheet-trihex.pdf
	
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

grayscale:
	gs -o notebook-sheet-grayscale.pdf -sDEVICE=pdfwrite -sProcessColorModel=DeviceGray -sColorConversionStrategy=Gray -dOverrideICC -f notebook-sheet.pdf
	gs -o notebook-sheet-hex-grayscale.pdf -sDEVICE=pdfwrite -sProcessColorModel=DeviceGray -sColorConversionStrategy=Gray -dOverrideICC -f notebook-sheet-hex.pdf
	gs -o notebook-sheet-trihex-grayscale.pdf -sDEVICE=pdfwrite -sProcessColorModel=DeviceGray -sColorConversionStrategy=Gray -dOverrideICC -f notebook-sheet-trihex.pdf

notebook: tools cover sheet sheet-hex grayscale

blok: notebook

tools-wide: tools-wide-front.pdf tools-wide-back.pdf | tools-wide-print.pdf
	pdfunite tools-wide-front.pdf tools-wide-back.pdf tools-wide.pdf

tools-wide-crop: tools-back.pdf tools-front.pdf
	$(PDFTEX) tools-wide-back-crop.tex
	$(PDFTEX) tools-wide-back-crop.tex
	$(PDFTEX) tools-wide-front-crop.tex
	$(PDFTEX) tools-wide-front-crop.tex
	pdfunite tools-wide-front-crop.pdf tools-wide-back-crop.pdf tools-wide-crop.pdf