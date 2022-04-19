clc
clear
close all
weak_data = csvread('附件1.csv',1,0);
weak_data2 = weak_data(weak_data(:,3)>3,:)

% 标签，0表示未被覆盖，1表示被宏基覆盖，-1表示被微基覆盖
label = zeros(1,size(weak_data2,1));
% 每个弱覆盖点唯一的id
id = 1:size(weak_data2,1);
weak_point = [weak_data2 label' id'];

existing_base_station = csvread('附件2.csv',1,0);
label2 = zeros(1,size(existing_base_station,1));
existing_base_station = [existing_base_station label2']
i = randi(2499,1,5000);
j = randi(2499,1,5000);

new_id = 8286;
for a=1:size(i,2)
    a
    for b=1:size(j,2)
        % ( i(a),j(a))是随机产生的坐标
        flag_cover = 0;
        exi_maxx = i(a)+10;
        exi_minx = i(a)+10;
        exi_maxy = j(a)+10;
        exi_miny = j(a)+10;
        %判断是否与现有基站邻近，基站之间在10以外
        adjacent_num = existing_base_station(existing_base_station(:,2)>=i(a) &existing_base_station(:,2)<=i(a)+10 & ...
        existing_base_station(:,3)>=j(a) &existing_base_station(:,3)<=j(a)+10,:);
           
        if size(adjacent_num,1)==0
            maxx = i(a)+30;
            minx = i(a)+10;
            maxy = j(a)+30;
            miny = j(a)+10;
            % 计算半径大于10，小于30的圆环的覆盖点
            macro_distance = weak_point(weak_point(:,1)>=minx & weak_point(:,1)<=maxx &...
                weak_point(:,2)>=miny & weak_point(:,2)<=maxy,:);
            % 在此圆环内，如果未被覆盖点大于100个以上就选择宏基，反之选择微基
            if length(find(macro_distance(:,4)==0))>20
                tmp1 = weak_point(:,5);
                tmp2 = macro_distance(:,5);
                v = find_index(tmp1,tmp2);
                % 标记被宏基覆盖
                weak_point(v,4) = 1 ;
                % 把新建基站添加进现有基站中
                new_id = new_id+1;
                existing_base_station = [existing_base_station;[new_id, i(a),j(a),1]];
            else
                tmp1 = weak_point(:,5);
                tmp2 = macro_distance(:,5);
                v = find_index(tmp1,tmp2);
                % 标记被微基覆盖
                weak_point(v,4) = -1;
                % 把新建基站添加进现有基站中
                new_id = new_id+1;
                existing_base_station = [existing_base_station;[new_id, i(a),j(a),-1]];
            end
        end

    end
end
% 宏基和微基的成本
F1 = length(find(weak_point(:,4)==1))*30+length(find(weak_point(:,4)==-1))
% 计算业务量覆盖率
% 覆盖点
cover_point = weak_point(weak_point(:,4)~=0,:);
F2 = sum(cover_point(:,3))./sum(weak_point(:,3))
f = F2./F1
% 如果业务量覆盖率小于90%，更新新建基站坐标
%     if f <0.9
%         i = randi(2499,1,2499);
%         j = randi(2499,1,2499);
%     end

% save existing_base_station
% save weak_point
save('现有基站和新建基站坐标_初始5000个坐标_去噪后',existing_base_station)
save('弱覆盖点坐标_初始5000个坐标_去噪后',weak_point)
% 查找一个数组在另一个数组中的索引，a是大数组，b是小数组
function [index] = find_index(a,b)
    index = [];
    for i = 1:length(b)
        idx = find(a==b(i));
        index = [index,idx];
    end
end

