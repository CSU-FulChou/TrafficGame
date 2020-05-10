% 机机变换——删除插入
function [pathd,k,M]=DDexchange2(patht,pathd,k,d,dd,M,T,weight,longdmax,Gdmax)
for i=1:length(M)
    number(i)=find(M(i)-1==k); %记录M在k的位置，为后续更新重复点做准备
end
index=1:length(pathd); %pathd的序号
index([1,k,end])=[];   %删除无人机起降点(因为相邻变换的特殊性，其他起降点后续排除)
c=floor(1+length(index)*rand(1,2)); %随机选取两个无人机节点
c=sort(c);c1=index(c(1));c2=index(c(2)); %假设删除点为序号小的节点，插入点为序号大的节点
% 判断该邻域变换后是否满足约束
loc1=find(k>c1);loc2=find(k>c2); %定位c1、c2所在段（k(i)前的段）
sd1=0;sd2=0;wd1=0;wd2=0;
if sum(loc1)==0 %最终段
    for i=k(end):length(pathd)-1
        sd1=sd1+dd(pathd(i),pathd(i+1));
        wd1=wd1+weight(pathd(i));
    end
    wd1=wd1-weight(pathd(k(end)));
elseif loc1(1)-1==0 %起始段
    for i=1:k(loc1(1))-1
        sd1=sd1+dd(pathd(i),pathd(i+1));
        wd1=wd1+weight(pathd(i));
    end
    wd1=wd1-weight(pathd(k(1)));
else %中间段
    for i=k(loc1(1)-1):k(loc1(1))-1
        sd1=sd1+dd(pathd(i),pathd(i+1));
        wd1=wd1+weight(pathd(i));
    end
    wd1=wd1-weight(pathd(k(loc1(1)-1)));
end
if sum(loc2)==0 %最终段
    for i=k(end):length(pathd)-1
        sd2=sd2+dd(pathd(i),pathd(i+1));
        wd2=wd2+weight(pathd(i));
    end
    wd2=wd2-weight(pathd(k(end)));
elseif loc2(1)-1==0 %起始段
    for i=1:k(loc2(1))-1
        sd2=sd2+dd(pathd(i),pathd(i+1));
        wd2=wd2+weight(pathd(i));
    end
    wd2=wd2-weight(pathd(k(1)));
else %中间段
    for i=k(loc2(1)-1):k(loc2(1))-1
        sd2=sd2+dd(pathd(i),pathd(i+1));
        wd2=wd2+weight(pathd(i));
    end
    wd2=wd2-weight(pathd(k(loc2(1)-1)));
end
if sd1 > longdmax | wd1 > Gdmax | sd2 > longdmax | wd2 > Gdmax
    return;
end
% 计算代价函数值的增量
if c2-c1==1 %相邻两点
    df=dd(pathd(c1-1),pathd(c2))+dd(pathd(c1),pathd(c2+1))-dd(pathd(c1-1),pathd(c1))-dd(pathd(c2),pathd(c2+1));
else %非相邻两点
    df=dd(pathd(c1-1),pathd(c1+1))+dd(pathd(c2-1),pathd(c1))+dd(pathd(c1),pathd(c2))...
        -dd(pathd(c1-1),pathd(c1))-dd(pathd(c1),pathd(c1+1))-dd(pathd(c2-1),pathd(c2));
end
if any(c1==[k+1,M+1] | c2==[k+1,M+1])
    return; %删除所有的无人机起降点
end
% 接受准则
if df<0
    pathd=pathd([1:c1-1,c1+1:c2,c1,c2+1:end]);
elseif exp(-df/T)>rand
    pathd=pathd([1:c1-1,c1+1:c2,c1,c2+1:end]);
end
% 修改重复点
k=[];
for i=1:length(pathd)-1
    if pathd(i)==pathd(i+1)
        k=[k i];
    end
end
M=k(number)+1;