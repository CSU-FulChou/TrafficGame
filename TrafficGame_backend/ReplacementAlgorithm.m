%替换算法
function [patht,pathd,M,k,N,long1,save_rate1]=ReplacementAlgorithm(path,d,dd,weight,longdmax,Gdmax,a,long0,sj1)
patht=path; %记录卡车路径patht
pathd=[];   %记录无人机路径pathd
i=2;        %从第二点开始为顾客点，第一点为仓库
M=[];       %存储人工标记点的位置
while i<=101
    deltad=dd(path(i-1),path(i))+dd(path(i),path(i+1))+d(path(i-1),path(i+1))-d(path(i-1),path(i))-d(path(i),path(i+1)) ; %初始替换的成本增加值（若为负，则替换）
    md=d(path(i-1),path(i))+d(path(i),path(i+1)); %无人机初始飞行距离
    mt=d(path(i-1),path(i+1)); %卡车初始行驶距离
    Gd=weight(path(i));  %无人机初始化载重
    j=i-1;               %记录上次车机会合点的序号
    if deltad<0 & md<=longdmax & Gd<=Gdmax & ~(any(i==a)) %替换条件及航程约束
        if sum(pathd)~=0 %判断矩阵非空
            if path(i-1)~=pathd(end) %降落点和起飞点不是同一点
                pathd=[pathd pathd(end)]; %重复记录最后一个点(降落点)，下一个点为起飞点
                M=[M length(pathd)]; %记录人工重复点的位置
            end
        end
        pathd=[pathd path(i-1)]; %记录无人机起飞点
    end
    while deltad<0 & md<=longdmax & Gd<=Gdmax & ~(any(i==a))
        patht(i)=0;            %将被替换的卡车点标记为0，此处不赋空矩阵是因为需要用i索引
        pathd=[pathd path(i)]; %将替换点放入无人机路径
        i=i+1;    %考虑下一个点
        if i>=102 %已遍历完所有点，跳出循环
            break
        end
        deltad=dd(path(i),path(i+1))+d(path(j),path(i+1))-d(path(j),path(i))-d(path(i),path(i+1)); %后续替换的成本增加值（若为负，则替换）
        md=md+d(path(i),path(i+1)); %计算本次航行无人机累积飞行距离
        Gd=Gd+weight(path(i));
    end
    if i>j+1 %证明是跑过上面的while循环后出来的，即i点为车机会合点，而不是无人机在车上走的
        pathd=[pathd path(i)]; %把降落点放入无人机路径,正常重复点
    end
    i=i+1; %考虑下一个点
end
patht(find(patht==0))=[];
k=[]; % k记录同车起降点
for i=1:length(pathd)-1     %i是pathd的序号
    if pathd(i)==pathd(i+1) %如果出现重复值
        k=[k i];            %用k矩阵记录重复点的序号
    end
end
N=[]; % 筛选出非人工重复点
for i=1:length(k)
    if ~any(k(i)==M-1)
        N=[N k(i)];
    end
end
longdd=0; %求改进后无人机飞行成本
exlongdd=0; %无人机与车同行的成本（此时无人机不飞）
for i=1:length(M)
    exlongdd=exlongdd+dd(pathd(M(i)),pathd(M(i)+1));
end
for nd=1:length(pathd)-1
    longdd=longdd+dd(pathd(nd),pathd(nd+1));
end
longdd=longdd-exlongdd;
%求加入无人机后车辆路径的距离长
longt=0;
for nt=1:length(patht)-1
    longt=longt+d(patht(nt),patht(nt+1));
end
long1=longdd+longt;                %求总长度long
save_rate1=(long0-long1)/long0;    %求节省路径的比
xxt=sj1(patht,1);yyt=sj1(patht,2);
xxd=sj1(pathd,1);yyd=sj1(pathd,2);
xxG=sj1(path(a),1);yyG=sj1(path(a),2);
% plot(xxt,yyt,'-*',xxd,yyd,'r--o',xxG,yyG,'r*') %画出巡航路径
% xlabel('经度')
% ylabel('纬度')
% title('车机协同初始路径')
% legend('货车配送路径','无人机配送路径')
% figure;