clc
clear all
close all

load existing_base_station
load weak_point

macro_base_all = existing_base_station(existing_base_station(:,4)>0,:);
micro_base_all = existing_base_station(existing_base_station(:,4)<0,:);

macro_random = randsample(1:size(macro_base_all,1),1105)
micro_random = randsample(1:size(micro_base_all,1),5002)

macro_base = macro_base_all(macro_random,:)
micro_base = micro_base_all(micro_random,:)

x_macro = macro_base(:,2);
y_macro = macro_base(:,3);

scatter(weak_point(:,1),weak_point(:,2),1,'b')
x_micro =micro_base(:,2);
y_micro =micro_base(:,3);

% 可视化宏基站
plot_circle(x_macro,y_macro,30);
% 可视化微基站
plot_circle(x_micro,y_micro,10);


function [] = plot_circle(x,y,r)
    for a = 1:size(x,1)
        a
        circle(x(a),y(a),r)
%         hold on
    end
end

function [] = circle(x,y,r )
    rectangle('Position',[x-r,y-r,2*r,2*r],'Curvature',[1,1],'linewidth',1,'EdgeColor','r'),axis equal
end


