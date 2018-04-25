#set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set terminal postscript eps enhanced color

set key samplen 2 spacing 1.5 font ",22"

set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"

set xlabel "No. of Elements"
set ylabel "Average Execution Time (in microSecs)"
set yrange[0:100000]
set xrange[0:1000000]
set ytic auto
set xtic auto



set key bottom right

set output "line_plot.eps"
plot 'avg.out' using 2:($1==1 ? $3 :1/0) title "Thread_1" with linespoints, \
     '' using 2:($1==2 ? $3 :1/0) title "Thread_2" with linespoints pt 5 lc 4,\
     '' using 2:($1==4 ? $3 :1/0) title "Thread_4" with linespoints lc 3,\
     '' using 2:($1==8 ? $3 :1/0) title "Thread_8" with linespoints lc 2,\
     '' using 2:($1==16 ? $3 :1/0) title "Thread_16" with linespoints lc 1,\
     
