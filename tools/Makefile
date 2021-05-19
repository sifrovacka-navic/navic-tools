SH=/bin/bash
TEX=lualatex -interaction=nonstopmode

all: alphabets | braille-lookup.pdf cyrillic.pdf greek.pdf keyboard.pdf main.pdf morse-tree.pdf numbers-table.pdf rainbow.pdf rosicrucian-polish.pdf rosicrucian-polish-v2.pdf semaphore-lookup.pdf train.pdf xmino.pdf
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

light: braille-lookup.pdf cyrillic.pdf greek.pdf keyboard.pdf main.pdf morse-tree.pdf numbers-table.pdf rainbow.pdf rosicrucian-polish.pdf rosicrucian-polish-v2.pdf semaphore-lookup.pdf train.pdf xmino.pdf
	touch ../front.tex
	touch ../back.tex
	touch ../print.tex
