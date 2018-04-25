data = load('train.csv');
X  =  data(:,1);
Y = data(:,2);
t = length(X);
new_x = [ones(t,1), data(:,1)];
w = ones(2,1);
w_l = (w') * (new_x');
plot(X,Y,'color','r');
% Helps to draw another graph in same graph

hold on;

plot(X, w_l,'color','g');
w_direct = (pinv((X')*X))*(X')*Y;
temp = (w_direct')*(new_x');
plot(X,Y,'color','r');

hold on;
plot(X,temp,'color','g');

eta = 0.00000001;
for i = 1:2
	for j = 1:t
		x_temp = new_x(j,:)';
		y_temp = Y(j,:);
		w = w - eta*(((w')*x_temp)-y_temp)*x_temp;
		w_l = (w')*(new_x');
		if mod(j,100) == 0
			plot(X,Y,'color','r');hold on;
			plot(X,w_l,'color','g');
		endif
    endfor
endfor

w_l = (w') * (new_x');
plot(X,Y,'color','r');

hold on;
plot(X,w_l,'color','g');

test_data = load('test.csv');
x_test = test_data(:,1);
x_test_len = length(x_test);
y_test = test_data(:,2);
x_test_new = [ones(x_test_len,1),test_data(:,1)];

y_pred_1 = x_test_new * w;
y_pred_2 = x_test_new * w_direct;

% RMS Values

e1 = y_pred_1 - y_test;
e2 = y_pred_2 - y_test;
sq1 = e1.^2;
sq2 = e2.^2;

rms1 = mean(sq1);
rms2 = mean(sq2);

disp(rms1)
disp(rms2)
