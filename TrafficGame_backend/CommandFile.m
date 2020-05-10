clc, clear, clf %清空上次运行后的命令行、工作区、图窗
tic %开始计时
sj0=load('sj.txt'); %加载数据文件（含100个目标的经纬度）
% sj0=sj0(1:12,:);  %调整问题规模
% weightdata=load('weight.mat');  %加载包裹重量
% weight=weightdata.weight;       %各包裹的重量
weight=[0,2.3*rand(1,100),0]; %随机生成100个包裹重量
vd=65;          %无人机设定速度
vt=40;          %货车的设定速度
Gdmax=10;       %无人机载重上限
longdmax=2500;  %无人机航程上限
a=find(weight>=2.3); %重货物点序号
TDrate=1/25;    %无人机与货车的成本比
[patht,pathd,long,save_ratefor0,save_ratefor1]=main(sj0,vd,vt,Gdmax,longdmax,weight,TDrate,a);
toc %计时结束