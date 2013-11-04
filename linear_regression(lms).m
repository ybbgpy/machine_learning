N=20;
x=linspace(0,1,N);
y_real=1+3*x;

noise_mean=0;
noise_var=0.2;
noise=normrnd(noise_mean,noise_var,1,N);

y_measure=y_real+noise;

plot(x,y_real,'g');
hold on
plot(x,y_measure,'o');

%initial theta
theta=[0,0];

%learning rate
alpha=0.001;

%mean_square_threshold
mean_square_thres=0.03;

count=0;

while 1
    
    %calculate the mean square
    sum_square=0;
    for i=1:N
        h=theta(1)+theta(2)*x(i);
        sum_square=sum_square+(y_measure(i)-h)^2;
    end
    mean_square=sum_square/N;
    disp(mean_square);
    if mean_square<mean_square_thres
        break;
    end
    
    count=count+1;
    if count>1000 
        alpha=alpha/10;
    end
    
    delta=[0,0];
    for i=1:N
        h=theta(1)+theta(2)*x(i);
        delta(1)=delta(1)+(y_measure(i)-h);
        delta(2)=delta(2)+(y_measure(i)-h)*x(i);
    end
    %disp(delta);
    theta=theta+alpha*delta;
    %disp(count);
    %disp(theta);
end

disp(theta)
y_hypo=theta(1)+theta(2)*x;
plot(x,y_hypo,'r');
hold off
