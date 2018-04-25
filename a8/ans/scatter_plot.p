set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
#set terminal postscript eps enhanced color

set key samplen 2 spacing 1 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set logscale x 10 
set logscale y 10 
set xlabel "No. of Elements"
set ylabel "Execution Time(sec)"
set yrange[0:100000]
set xrange[0:1000000]
set ytic auto
set xtic auto


set output "scatter_1.eps"
plot 'data.out' using 2:($1==1 ? $3:1/0 ) notitle with points pt 1 ps 1.5

set output "scatter_2.eps"
plot 'data.out' using 2:($1==2 ? $3:1/0 ) notitle with points pt 1 ps 1.5

set output "scatter_3.eps"
plot 'data.out' using 2:($1==4 ? $3:1/0 ) notitle with points pt 1 ps 1.5

set output "scatter_4.eps"
plot 'data.out' using 2:($1==8 ? $3:1/0 ) notitle with points pt 1 ps 1.5

set output "scatter_5.eps"
plot 'data.out' using 2:($1==16 ? $3:1/0 ) notitle with points pt 1 ps 1.5
