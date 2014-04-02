DOC = dissertation.tex
DOC_BASE := $(shell basename $(DOC) .tex)
PDFLATEX = latex 
BIBTEX = bibtex
RERUN = "(There were undefined (references|citations)|Rerun to get (cross-references|the bars) right)"
RERUNBIB = "No file.*\.bbl|Citation.*undefined"
TARDIR = $(DOC:.tex=-src)
SED_MATCH = "s/Toward Preventing Server-Side XSS via Automatic Code and Data Separation/Toward Preventing Server-Side XSS/g"

.PHONY: pdf clean

pdf: $(DOC:.tex=.pdf)

all: pdf

%.pdf: %.tex *.tex *.bib
	rm -f $(DOC_BASE).bbl
	${PDFLATEX} $<
	echo "TERRIBLE HACK TO FIX TOC HEADER"
	sed -i $(SED_MATCH) $(DOC_BASE).toc
	egrep -c $(RERUNBIB) $*.log && ($(BIBTEX) $*;$(PDFLATEX) $<) ; true
	sed -i $(SED_MATCH) $(DOC_BASE).toc
	egrep $(RERUN) $*.log && ($(PDFLATEX) $<) ; true
	sed -i $(SED_MATCH) $(DOC_BASE).toc
	egrep $(RERUN) $*.log && ($(PDFLATEX) $<) ; true
	egrep -i "(Reference|Citation).*undefined" $*.log ; true
	dvips -o $(DOC_BASE).ps -t letter $(DOC_BASE).dvi
	ps2pdf14 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true $(DOC_BASE).ps


clean:
	find . -name "*.aux" | xargs rm -f
	find . -name "*.log" | xargs rm -f
	find . -name "*.out" | xargs rm -f
	@\rm -f \
        $(DOC:.tex=.dvi) \
        $(DOC:.tex=.pdf) \
        $(DOC:.tex=.ps)  \
        $(DOC:.tex=.bbl) \
        $(DOC:.tex=.blg) \
        $(DOC:.tex=.lof) \
        $(DOC:.tex=.lot) \
        $(DOC:.tex=.loc) \
        $(DOC:.tex=.lol) \
	$(DOC:.tex=-src.tar.gz)

veryclean: clean
	@\rm -f *~ *.log

tar: pdf
	@test -d $(TARDIR) || mkdir $(TARDIR)
	@cp Makefile *.{tex,bib,bst,cls} $(TARDIR)
	@tar cz $(TARDIR) > $(TARDIR).tar.gz
	@rm -rf $(TARDIR)
