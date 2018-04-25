num_samp = 50000
lambda = 0.2
x <- rexp(num_samp, lambda)
##Create a SCatter plot below
data <- rexp(num_samp, 0.2)
q <- data.frame(X = seq(1, num_samp , 1), Y = sort(data))
plot(q)

#Sys.sleep(1)
collection <- split(x, ceiling(seq_along(x)/100))
some_means <- c()
sds <- c()
for (i in 1:5){
	hx <- dexp(collection[[i]]) 
	some_means[[i]] <- mean(hx)
	sds[[i]] <- sd(hx)
	plot(collection[[i]], hx, xlab="X Values sampled from Exp-Distribution", ylab=paste("Probability Density Function for ", i, " vector"), cex=0.4)
	#Sys.sleep(1)
	plot.ecdf(hx, xlab="X Values sampled from Exp-Distribution", ylab="Cumulative Density Function", cex=0.4)
	#Sys.sleep(1)
}

all_means <- c()
for(i in 1:500){
	all_means[[i]] <- mean(collection[[i]])
}

tab = table(round(all_means))
plot(tab, "h", xlab="Value", ylab="Frequency", xlim=c(3,7))


pdata <- rep(0, 100);

for(i in 1:500){
    val=round(all_means[i], 0);
    if(val <= 100){
       pdata[val] = pdata[val] + 1/ 100; 
    }
}

xcols <- c(0:99)

str(pdata)
str(xcols)

plot(xcols, pdata, "l", xlab="X", ylab="f(X)", xlim=c(0,8))

cdata <- rep(0, 100)

cdata[1] <- pdata[1]

for(i in 2:100){
    cdata[i] = cdata[i-1] + pdata[i]
}

plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)", xlim=c(0,10));
#Plotting Pdf and cdf and cdf and cdf and cdf
#hx <- dexp(x)
#plot(x, hx,	xlab="X Values sampled from Exp-Distribution", ylab="Probability Density Function", cex=0.4)
#plot.ecdf(hx, xlab="X Values sampled from Exp-Distribution", ylab="Cumulative Density Function", cex=0.4)

print("The mean of Exp-Dist is 1/(lambda) = 5 here. In the case of sampled values, we get the mean to be = ")
print(mean(x))
print("The standard_deviation of Exp-Dist is 1/(lambda) = 5 here. In the case of sampled values, we get the  to be = ")
print(sd(x))
##num_samp = 50000
##lambda = 0.2
##x <- rexp(num_samp, lambda)
###Create a SCatter plot below


##x <- seq(0, 20, length=num_samp)
##y <- dexp(x)
##plot(x, y)
###plots the pdf of Exponential Distribution
##x <- data.frame(X = seq(1, num_samp , 1), Y = sort(data, decreasing=T))
##plot(x)

