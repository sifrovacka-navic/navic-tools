SH=/bin/bash

ALPHABETS = $(sort $(dir $(wildcard */)))

SOURCES = $(wildcard */*.svg)
TARGETS = $(SOURCES:.svg=.pdf)

all: colors ${TARGETS}

colors:
	for DIR in ${ALPHABETS} ; do \
		cd $${DIR} ; \
		if [ -f replace_colors.py ]; then echo "Replacing in $${DIR}"; python replace_colors.py; fi ; \
		cd .. ; \
	done

%.pdf: %.svg
	inkscape $< --export-text-to-path --export-filename=$@

clean:
	for DIR in ${ALPHABETS} ; do \
		rm -f $${DIR}*.pdf;\
	done
