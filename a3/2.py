#!/usr/bin/env python3
import numpy as np
import matplotlib.pyplot as plt
import csv
import sys
#training
if len(sys.argv) != 3:
    sys.exit("Too few or too many arguments. 3 arguments needed. Exiting");
n_train=10000
trainpath = sys.argv[1] 
raw_data = open(trainpath, 'rt')
data = np.loadtxt(raw_data, delimiter=",",skiprows=1)
x = np.c_[np.ones(data.shape[0]),data[:,0]]
y = np.c_[data[:,1]]
w = np.random.rand(2).reshape((2,1))
# w = np.random.rand((2,1))
plt.scatter(x[:,1], y , c='r', marker='.', linewidths=1)
wt = np.transpose(w)
xt = np.transpose(x)
g = wt.dot(xt)
# print(g.shape)
plt.plot(x[:,1], g.reshape(g.shape[1]),'-o')
# plt.show()
# sys.exit()
w_direct = np.linalg.pinv(xt.dot(x)).dot(xt.dot(y))
w_direct_t=np.transpose(w_direct)
plt.scatter(x[:,1], y , c='r', marker='.', linewidths=1)
plt.plot(x[:,1],w_direct_t.dot(xt).reshape(10000),'-o')
plt.plot()
for i in range(1,10):
	for j in range(1,n_train):
		xtemp = x[j,:].reshape((2,1))
		ytemp = y[j][0]
		xtempt= xtemp
		print("xtemp.shape = ", xtempt.shape)
		eta = 0.000005
		wt1 = np.transpose(w)
		print("x.shape ", x.shape, "xtempt.shape ", xtemp.shape, "wt1.shape = " , wt1.shape, "ytemp = ", ytemp)
		print((wt1.dot(xtemp)-ytemp).reshape(-1)[0])
		w = w - eta*((wt1.dot(xtemp)-ytemp).reshape(-1)[0]-ytemp)*(xtempt)
		if(j%100==0):
			wt1 = np.transpose(w)
			plt.scatter(x[:,1], y , c='r', marker='.', linewidths=1)
			plt.plot(x[:,1],wt1.dot(xt).reshape(10000),'-o')
			plt.plot()


wt1 = np.transpose(w)
plt.scatter(x[:,1], y , c='r', marker='.', linewidths=1)
plt.plot(x[:,1],wt1.dot(xt).reshape(10000),'-o')
plt.plot()

#TESTING----
raw_data2 = open(sys.argv[2], 'rt')
data2 = np.loadtxt(raw_data2, delimiter=",",skiprows=1)
xtest = np.c_[np.ones(data2.shape[0]),data2[:,0]]
ytest = np.c_[data2[:,1]]
n_test = 10500	
print(w)
ypred1 = xtest.dot(w)
ypred2 = xtest.dot(w_direct) 
J1 = 1/(2*n_test)*np.sum(np.square(ypred1-ytest))
J2 = 1/(2*n_test)*np.sum(np.square(ypred2-ytest))
print(J1)
print(J2)
