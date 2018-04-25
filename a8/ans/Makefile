all:cs251.pdf    

cs251.pdf:report.tex 
	pdflatex report.tex
report.tex:scatter_1.eps scatter_2.eps scatter_3.eps scatter_4.eps scatter_5.eps line_plot.eps speedup_errorbar.eps speedup.eps 
		
scatter_1.eps:scatter_plot.p data.out avg.out speedup.out
	gnuplot scatter_plot.p
scatter_2.eps:scatter_plot.p data.out avg.out speedup.out
	gnuplot scatter_plot.p
scatter_3.eps:scatter_plot.p data.out avg.out speedup.out
	gnuplot scatter_plot.p
scatter_4.eps:scatter_plot.p data.out avg.out speedup.out
	gnuplot scatter_plot.p
scatter_5.eps:scatter_plot.p data.out avg.out speedup.out
	gnuplot scatter_plot.p
line_plot.eps:line_plot.p data.out avg.out speedup.out
	gnuplot line_plot.p
speedup.eps:bar_plot.p data.out avg.out speedup.out
	gnuplot bar_plot.p
speedup_errorbar.eps:bar_plot.p data.out avg.out speedup.out
	gnuplot bar_plot.p
data.out:params.txt threads.txt a.out
	./script.py params.txt threads.txt
avg.out:params.txt threads.txt a.out
	./script.py params.txt threads.txt
speedup.out:params.txt threads.txt a.out
	./script.py params.txt threads.txt
app:a.out

a.out:prog.c thread_function.c common.h 
	gcc -lm -lpthread  thread_function.c prog.c -I .

plot:scatter_1.eps scatter_2.eps scatter_3.eps scatter_4.eps scatter_5.eps line_plot.eps speedup_errorbar.eps speedup.eps 
		
report:report.tex 
	pdflatex report.tex	
analyse:data.out avg.out speedup.out

runtest:data.out avg.out speedup.out

clean:
	rm -f *.out *.eps report.aux report.log  *.pdf *.o
