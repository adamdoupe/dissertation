DOC = dissertation.tex
DOC_BASE := $(shell basename $(DOC) .tex)
PDFLATEX = pdflatex 
BIBTEX = bibtex
RERUN = "(There were undefined (references|citations)|Rerun to get (cross-references|the bars) right)"
RERUNBIB = "No file.*\.bbl|Citation.*undefined"
TARDIR = $(DOC:.tex=-src)

.PHONY: pdf clean

pdf: $(DOC:.tex=.pdf)

all: pdf

%.pdf: %.tex *.tex *.bib
	rm -f $(DOC_BASE).bbl
	${PDFLATEX} $<
	egrep -c $(RERUNBIB) $*.log && ($(BIBTEX) $*;$(PDFLATEX) $<) ; true
	egrep $(RERUN) $*.log && ($(PDFLATEX) $<) ; true
	egrep $(RERUN) $*.log && ($(PDFLATEX) $<) ; true
	egrep -i "(Reference|Citation).*undefined" $*.log ; true
#	dvips -o $(DOC_BASE).ps -t letter $(DOC_BASE).dvi
#	ps2pdf14 -dPDFSETTINGS=/prepress -dEmbedAllFonts=true $(DOC_BASE).ps


clean:
	@\rm -f \
	*.aux \
        $(DOC:.tex=.aux) \
        $(DOC:.tex=.log) \
        $(DOC:.tex=.out) \
        $(DOC:.tex=.dvi) \
        $(DOC:.tex=.pdf) \
        $(DOC:.tex=.ps)  \
        $(DOC:.tex=.bbl) \
        $(DOC:.tex=.blg) \
	$(DOC:.tex=-src.tar.gz)

veryclean: clean
	@\rm -f *~ *.log

tar: pdf
	@test -d $(TARDIR) || mkdir $(TARDIR)
	@cp Makefile *.{tex,bib,bst,cls} $(TARDIR)
	@tar cz $(TARDIR) > $(TARDIR).tar.gz
	@rm -rf $(TARDIR)
