% 输出车机协同路径和成本使用情况，并绘制示意图
function [patht,xxt,yyt,pathd,xxd,yyd,xxG,yyG,long,save_ratefor0,save_ratefor1]=PrintAndPlot(path,patht,pathd,sj1,M,a,d,dd,long0,long1)
% 绘制示意图
xxt=sj1(patht,1);yyt=sj1(patht,2);
xxd=sj1(pathd,1);yyd=sj1(pathd,2);
xxG=sj1(path(a),1);yyG=sj1(path(a),2);
plot(xxt,yyt,'-*',xxd,yyd,'r--o',xxG,yyG,'r*') %画出巡航路径
title('车机协同优化路径')
legend('货车配送路径','无人机配送路径')
% 求成本节省的比例
longdd=0;   %求改进后无人机飞行成本
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
long=longdd+longt; %求总长度long
save_ratefor0=(long0-long)/long0*100;  %相对货车单独配送的成本节省率
save_ratefor1=(long1-long)/long1*100;  %相对初始解的成本节省率
fprintf('车机协同配送路径如下：\n');
fprintf('货车路径为：\n');
disp(patht);
fprintf('无人机路径为：\n');
disp(pathd);
fprintf('货车单独配送总成本：%.2f元\n',long0);
fprintf('初始解的配送总成本：%.2f元\n',long1);
fprintf('车机协同配送总成本：%.2f元\n',long);
fprintf('比货车单独配送节省：%.2f%%\n',save_ratefor0);
fprintf('比初始协同配送节省：%.2f%%\n',save_ratefor1);
% repeat1=[];
% repeat2=[];
% for i=1:length(M)
%     if find(path==pathd(M(i)+1))-find(path==pathd(M(i)))~=1
%         repeat1=[repeat1 pathd(M(i)) pathd(M(i)+1)];          %筛选：上一次无人机降落点的后几个点为下一次无人机起飞点
%     else
%         repeat2=[repeat2 pathd(M(i)) pathd(M(i)+1)];          %筛选：上一次无人机降落点的后一个点为下一次无人机起飞点
%     end
% end
% xrepeat1=sj1(repeat1,1);yrepeat1=sj1(repeat1,2);
% xrepeat2=sj1(repeat2,1);yrepeat2=sj1(repeat2,2);
% for i=1:2:length(xrepeat1)
%     hold on
%     plot([xrepeat1(i) xrepeat1(i+1)],[yrepeat1(i) yrepeat1(i+1)],'-w');
% end
% hold on
% for i=1:2:length(xrepeat2)
%     hold on
%     plot([xrepeat2(i) xrepeat2(i+1)],[yrepeat2(i) yrepeat2(i+1)],'-b');
% end