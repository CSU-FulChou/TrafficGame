% 车车优化的删除-插入与节点交换
function patht=TTexchange1(patht,pathd,M,d,dd,T)
for i=1:length(M)         %依据人工重复点来寻找满足条件的情况
    number1=M(i)+1;       %无人机起飞点序号
    number2=find(patht==pathd(M(i)))+1;  %寻找可以向无人机飞行的内部 移入的卡车点序号（在卡车路径点中的序号）
%     if length(number2)>1
%         M,patht,pathd,number2
%     end
    q=pathd(number1);
    if  patht(number2)~=q & length(patht)>=number2+1         %筛选相邻的两段无人机路径间存在卡车点的情况
        save1=d(patht(number2-2),patht(number2))+d(patht(number2-1),patht(number2+1))-d(patht(number2-2),patht(number2-1))-d(patht(number2),patht(number2+1)); %插入删除下的成本节省值
        save2=dd(pathd(M(i)-2),patht(number2))-dd(pathd(M(i)-2),pathd(M(i)-1));  %节点交换下的成本节省值
        if save1<0 & save2-save1>0   %说明删除插入后成本值节省大  不需要再进行节点交换
            mid=patht(number2-1);
            patht(number2-1)=patht(number2);
            patht(number2)=mid;         %更新卡车路径中的点
        elseif  save2<0 & save1-save2>0   %说明节点交换后的成本值较大
            pathd(M(i))=patht(number2);
            pathd(M(i)-1)=patht(number2);    %更新无人机路径中的点
        end
    end
end