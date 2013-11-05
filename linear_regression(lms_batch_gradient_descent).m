N=20;
x=linspace(0,1,N);
y_real=1+3*x;

noise_mean=0;
noise_var=0.2;
noise=normrnd(noise_mean,noise_var,1,N);

y_measure=y_real+noise;


plot(x,y_real,'g');
axis([0 1 0 5]);
hold on
plot(x,y_measure,'o');

%initial theta
theta=[0,0];

%learning rate
alpha=0.001;

%theta_threshold
theta_thres=0.01;

count=0;

while 1
    
    delta=[0,0];
    for i=1:N
        h=theta(1)+theta(2)*x(i);
        delta(1)=delta(1)+(y_measure(i)-h);
        delta(2)=delta(2)+(y_measure(i)-h)*x(i);
    end
    if delta(1)<theta_thres && delta(2)<theta_thres
        break;
    end
    %disp(delta);
    theta=theta+alpha*delta;
    %disp(count);
    %disp(theta);
end

disp(theta);
y_hypo=theta(1)+theta(2)*x;
plot(x,y_hypo,'r');
hold off
