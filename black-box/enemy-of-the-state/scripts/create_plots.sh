#!/bin/sh

for i in data/*.gplot;
do
	file=$(basename $i)
	just_name=${file%%.*}

	gnuplot "data/$file"
	epspdf "figures/$just_name.eps" "figures/$just_name.pdf"
done





for i in figures/*.dot;
do
	file=$(basename $i)
	just_name=${file%%.*}
	dot -Tps $i > figures/$just_name.ps && ps2pdf figures/$just_name.ps figures/$just_name.pdf
done

