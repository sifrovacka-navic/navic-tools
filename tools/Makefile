SH=/bin/bash
TEX=lualatex -interaction=nonstopmode

all: alphabets | alphabet.pdf braille-lookup.pdf cyrillic.pdf czech.pdf greek.pdf keyboard.pdf keyboard-v2.pdf main.pdf main-narrow.pdf morse-tree.pdf numbers-table.pdf numbers-table-v2.pdf numbers-table-v3.pdf rainbow.pdf rainbow-v2.pdf rosicrucian-polish.pdf rosicrucian-polish-v2.pdf semaphore-lookup.pdf train.pdf xmino.pdf xmino-v2.pdf navic.pdf
	touch ../front.tex
	touch ../back.tex
	touch ../print.tex

%.pdf: %.tex 
	rm -f %.xmpdata %.aux %.pdf
	$(TEX) $<
	$(TEX) $<
	
clean:
	rm -f *.log *.dvi *.aux *.toc *.lof *.lot *.out *.bbl *.blg *.xmpi *.nlo *.nls *.pdf *.xmpdata

alphabets: 
	cd alphabets && $(MAKE)

light: braille-lookup.pdf cyrillic.pdf czech.pdf greek.pdf keyboard.pdf main.pdf morse-tree.pdf numbers-table.pdf numbers-table-v2.pdf numbers-table-v3.pdf rainbow.pdf rosicrucian-polish.pdf rosicrucian-polish-v2.pdf semaphore-lookup.pdf train.pdf xmino.pdf navic.pdf 
	touch ../front.tex
	touch ../back.tex
	touch ../print.tex
