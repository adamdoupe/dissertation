#!/bin/sh

for i in data/*.gplot;
do
	file=$(basename $i)
	just_name=${file%%.*}

	echo "Not rebuilding the graphs, because only the original will work with gnuplot."
	#gnuplot "data/$file"
	#epspdf "figures/$just_name.eps" "figures/$just_name.pdf"
done





for i in figures/*.dot;
do
	file=$(basename $i)
	just_name=${file%%.*}
#	dot -Tps $i > figures/$just_name.ps && ps2pdf figures/$just_name.ps figures/$just_name.pdf
	python2 ./scripts/dot2tex-2.8.7/dot2tex/dot2tex.py -f tikz --figonly --autosize --usepdflatex --template "template.tex" --texmode raw figures/$just_name.dot > figures/$just_name.tex
done

