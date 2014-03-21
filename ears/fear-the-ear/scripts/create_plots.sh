#!/bin/sh

gnuplot data/create_plots.gplot
epspdf figures/white_box_perf_graph.eps figures/white_box_perf_graph.pdf

dot -Tps figures/white_box_diagram.dot > figures/white_box_diagram_raw.ps && ps2pdf figures/white_box_diagram_raw.ps figures/white_box_diagram_raw.pdf
dot -Tps figures/complex_ear_diagram.dot > figures/complex_ear_diagram.ps && ps2pdf figures/complex_ear_diagram.ps figures/complex_ear_diagram.pdf
#dot -Txdot figures/white_box_diagram.dot | dot2tex -f tikz --autosize --crop  > figures/white_box_diagram_raw.tex
#pdflatex -output-directory figures white_box_diagram_raw.tex
