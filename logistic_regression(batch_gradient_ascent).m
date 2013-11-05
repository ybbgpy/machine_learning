% logistic regression using batch gradient ascent

training_data=load('old_faithful_labeled_data.txt');

% change class label from 1,2 to 0,1
training_data(:,3)=training_data(:,3)-1;

[point_num,data_dimension]=size(training_data);
X0=ones(point_num,1);
training_data=[X0 training_data];
theta=zeros(1,data_dimension);
theta_thres=0.03;
alpha=0.01;
while 1
    delta=zeros(1,data_dimension);
    for i=1:point_num
        point=training_data(i,1:3);
        label=training_data(i,4);
        h=1/(1+exp(-theta*point'));
        delta=delta+alpha*(label-h)*point;
    end
%     disp('delta:');
%     disp(delta);
    if sqrt(dot(delta,delta)) < theta_thres
        break;
    end
    theta=theta+delta;
    disp('theta:');
    disp(theta);
end
disp(theta);
hold on;
%axis([0 10 0 100]);
for i=1:point_num
    point=training_data(i,2:data_dimension+1);
   if point(data_dimension) == 0
       plot(point(1),point(2),'ob');
   else 
       plot(point(1),point(2),'or');
   end
end
% X1=linspace(0,6,60);
% X2=-theta(1)/theta(3)-theta(2)/theta(3)*X1;
% plot(X1,X2,'.');
fplot(@(x)(-theta(1)/theta(3)-theta(2)/theta(3)*x),[0 6]);
hold off
