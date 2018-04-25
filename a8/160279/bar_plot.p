set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "speedup.eps"

set key font ",22"
set xtics font ",22"
set ytics font ",22"
set ylabel font ",25"
set xlabel font ",25"
set xlabel "No. of Elements"
set ylabel "Average Speedup"
set yrange[0:4]
set ytic auto
set boxwidth 1 relative
set style data histograms
set style histogram cluster
set style fill pattern border
plot 'speedup.out' u 2:xticlabels(1) title "Thread_1",\
'' u 3 title "Thread_2" fillstyle pattern 7,\
'' u 4 title "Thread_4" fillstyle pattern 12,\
'' u 5 title "Thread_8" fillstyle pattern 14,\
'' u 6 title "Thread_16" fillstyle pattern 16,\


set term postscript eps enhanced monochrome 20 dashed dashlength 1 lw 1.5
set output "speedup_errorbar.eps"
set xtics rotate by -45
set style histogram errorbars lw 3
set style data histogram

plot 'speedup.out' u 2:7:xticlabels(1) title "Thread_1",\
'' u 3:8 title "Thread_2" fillstyle pattern 7,\
'' u 4:9 title "Thread_4" fillstyle pattern 12,\
'' u 5:10 title "Thread_8" fillstyle pattern 14,\
'' u 6:11 title "Thread_16" fillstyle pattern 16                                        ,\
