K=2;
data=load('old_faithful.txt');

%initialize the class center
data_size=size(data);
point_num=data_size(1);
rand_perm=randperm(point_num);
rand_point_1=rand_perm(1);
rand_point_2=rand_perm(2);
u_1=data(rand_point_1,:);
u_2=data(rand_point_2,:);

class_arr=zeros(1,point_num);
while 1
    change_count=0;
    for i=1:point_num
        point=data(i,:);
        euclid_distance_1=sqrt((point(1)-u_1(1))^2+(point(2)-u_1(2))^2); 
        euclid_distance_2=sqrt((point(1)-u_2(1))^2+(point(2)-u_2(2))^2);
        if euclid_distance_1<euclid_distance_2
            if class_arr(i) ~= 1
                change_count=change_count+1;
                class_arr(i)=1;
            end
        else
            if class_arr(i) ~= 2
                change_count=change_count+1;
                class_arr(i)=2;
            end
        end
    end
    
    %converge condition: no change point
    if change_count == 0
        break;
    end

    %revalue class center
    u_1=[0 0];
    u_2=[0 0];
    class_1_point_num=0;
    class_2_point_num=0;
    for i=1:point_num
        if class_arr(i) == 1
            u_1=u_1+data(i,:);
            class_1_point_num=class_1_point_num+1;
        else
            u_2=u_2+data(i,:);
            class_2_point_num=class_2_point_num+1;
        end
    end
    u_1=u_1/class_1_point_num;
    u_2=u_2/class_2_point_num;
end
% disp(u_1);
% disp(u_2);
% disp(class_1_point_num);
% disp(class_2_point_num);

hold on;
plot(u_1(1),u_1(2),'gX');
plot(u_2(1),u_2(2),'gX');
for i=1:point_num
    point=data(i,:);
    
   if class_arr(i) == 1
       plot(point(1),point(2),'ob');
   else 
       plot(point(1),point(2),'or');
   end
   
end
hold off
