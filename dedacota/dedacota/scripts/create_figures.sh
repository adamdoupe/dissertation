#!/bin/sh

# for i in data/*.gplot;
# do
# 	file=$(basename $i)
# 	just_name=${file%%.*}

# 	gnuplot "data/$file"
# 	epspdf "figures/$just_name.eps" "figures/$just_name.pdf"
# done





for i in figures/*.dot;
do
	file=$(basename $i)
	just_name=${file%%.*}
	python2 ./scripts/dot2tex-2.8.7/dot2tex/dot2tex.py --figonly --autosize --usepdflatex --texmode raw figures/$just_name.dot > figures/$just_name.tex
done

