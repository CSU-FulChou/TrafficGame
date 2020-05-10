%遗传算法求初始解
function [long0,path,d,dd,sj1]=GAInitial(sj0,TDrate)
%% 将100组经纬度数据转化为距离，用d矩阵储存(d需要按照路网来改成实际距离)
x=sj0(:,[1:2:8]);x=x(:); %取出经度数据
y=sj0(:,[2:2:8]);y=y(:); %取出纬度数据
sj1=[x y]; d1=[70,40];   %将经纬度数据用2列的矩阵储存，加入起终点坐标
sj1=[d1;sj1;d1]; sj=sj1*pi/180;  %角度化成弧度
d=zeros(102); %距离矩阵d初始化
for i=1:101  %经纬度转化为距离数据
    for j=i+1:102
        d(i,j)=6370*acos(cos(sj(i,1)-sj(j,1))*cos(sj(i,2))*cos(sj(j,2))+sin(sj(i,2))*sin(sj(j,2)));
    end
end
d=d+d';
dd=d*TDrate; %无人机距离矩阵
w=50; g=100; %w为种群的个数，g为进化的代数
rand('state',sum(clock)); %初始化随机数发生器
for k=1:w    %通过改良圈算法选取初始种群
    c=randperm(100); %产生1，...，100的一个全排列
    c1=[1,c+1,102];  %生成初始解
    for t=1:102 %该层循环是修改圈
        flag=0; %修改圈退出标志
        for m=1:100
            for n=m+2:101
                if d(c1(m),c1(n))+d(c1(m+1),c1(n+1))<d(c1(m),c1(m+1))+d(c1(n),c1(n+1))
                    c1(m+1:n)=c1(n:-1:m+1);  flag=1; %修改圈
                end
            end
        end
        if flag==0
            J(k,c1)=1:102; break %记录下较好的解并退出当前层循环
        end
    end
end
J(:,1)=0; J=J/102; %把整数序列转换成[0,1]区间上的实数，即转换成染色体编码
%交叉、变异操作：
for k=1:g  %该层循环进行遗传算法的操作
    A=J;   %交配产生子代B的初始染色体
    c=randperm(w); %产生下面交叉操作的染色体对
    for i=1:2:w
        F=2+floor(100*rand(1)); %产生交叉操作的地址
        temp=A(c(i),[F:102]);   %中间变量的保存值
        A(c(i),[F:102])=A(c(i+1),[F:102]); %交叉操作,第i行的第F到102列与第i+1行的第F到102列互换
        A(c(i+1),F:102)=temp;
    end
    by=[];  %为了防止下面产生空地址，这里先初始化
    while ~length(by)
        by=find(rand(1,w)<0.1); %产生变异操作的地址（需要变换的行序号）
    end
    B=A(by,:); %产生变异操作的初始染色体（需要变换的行）
    for j=1:length(by)
        bw=sort(2+floor(100*rand(1,3)));  %产生变异操作的3个地址
        B(j,:)=B(j,[1:bw(1)-1,bw(2)+1:bw(3),bw(1):bw(2),bw(3)+1:102]); %1:u-1,v+1:w,w+1:102在原位置不变，把u到v的基因片段放到w后面
    end
    G=[J;A;B]; %父代和子代种群合在一起；初始解50代，交叉产生50个，交叉的基础上10%个体发生变异
    [SG,ind1]=sort(G,2); %把染色体翻译成1，...,102的序列ind1
    num=size(G,1); long=zeros(1,num); %路径长度的初始值
    for j=1:num
        for i=1:101
            long(j)=long(j)+d(ind1(j,i),ind1(j,i+1)); %计算每条路径长度
        end
    end
    [slong,ind2]=sort(long); %对路径长度按照从小到大排序
    J=G(ind2(1:w),:); %精选前w个较短的路径对应的染色体
end
path=ind1(ind2(1),:);%此时解的路径及路径长度
% 求第一次遗传算法优化后的总成本（与后续比较）
long0=0;
for nd=1:length(path)-1
    long0=long0+d(path(nd),path(nd+1));
end
long0;
% path=ind1(ind2(1),:);flong=slong(1);  %解的路径及路径长度
% xx=sj1(path,1);yy=sj1(path,2);
% plot(xx,yy,'-*') %画出路径
% xlabel('经度')
% ylabel('纬度')
% title('货车单独配送较优路径')
% figure;