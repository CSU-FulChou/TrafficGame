%输入参数：
%  sj0顾客的经纬度数据；vd无人机的设定速度；vt货车的设定速度；Gdmax无人机载重上限；
%  longdmax无人机航程上限；weight各包裹的重量；TDrate无人机与货车的成本比；a重货物点序号
%输出参数：
%  patht货车的路径；pathd无人机的路径；long车机协同配送成本；
%  save_ratefor0：车机协同相比货车单独配送的成本节省率
%  save_ratefor1：车机协同相比初始解的成本节约率
function [patht,pathd,long,save_ratefor0,save_ratefor1]=main(sj0,vd,vt,Gdmax,longdmax,weight,TDrate,a)
% Step1：遗传算法，求解较优的货车主路径
[long0,path,d,dd,sj1]=GAInitial(sj0,TDrate);
% Step2：替换算法，将部分卡车点替换为无人机点，得到初始车机协同路径
[patht,pathd,M,k,N,long1]=ReplacementAlgorithm(path,d,dd,weight,longdmax,Gdmax,a,long0,sj1);
% Step3：模拟退火算法，车机协同路径优化
e=0.1^30;L=200000;at=0.999;T=1; 
for i=1:L
    flag=floor(1+6*rand);
    switch flag
        case{1} % 车机变换——正常重复点
            [patht,pathd,k]=TDexchange1(patht,pathd,d,dd,weight,longdmax,Gdmax,k,M,N,a,T);
        case{2} % 车机变换——人工重复点
            [patht,pathd]=TDexchange2(path,patht,pathd,d,dd,weight,longdmax,Gdmax,k,M,a,T);
        case{3} % 机机变换——全局二变换
            pathd=DDexchange1(patht,pathd,k,d,dd,M,T,weight,longdmax,Gdmax);
        case{4} % 机机变换——删除插入
            [pathd,k,M]=DDexchange2(patht,pathd,k,d,dd,M,T,weight,longdmax,Gdmax);
        case{5} % 车车变换——删除插入
            patht=TTexchange1(patht,pathd,M,d,dd,T);
        case{6} % 车车变换——相邻二交换
            patht=TTexchange2(patht,pathd,k,M,d,dd,T);
    end
    T=T*at; %按照0.999的降温系数进行降温
    if T<e  %判断退火过程是否结束
        break;
    end
end
% Step4：输出与绘图函数，包括：车机协同较优路径与经纬度，计算成本使用情况，绘制示意图
[patht,xxt,yyt,pathd,xxd,yyd,xxG,yyG,long,save_ratefor0,save_ratefor1]=PrintAndPlot(path,patht,pathd,sj1,M,a,d,dd,long0,long1);
patht=[patht' xxt yyt]; 
pathd=[pathd' xxd yyd];
heavybag=[path(a)' xxG yyG];
% 把路径与经纬度放到同一矩阵