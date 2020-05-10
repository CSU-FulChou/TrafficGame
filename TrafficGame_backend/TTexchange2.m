% 车车变换——节点交换
function patht=TTexchange2(patht,pathd,k,M,d,dd,T)
i=floor(2+(length(k)-1)*rand);
loc1=find(patht==pathd(k(i-1)));
loc2=find(patht==pathd(k(i)));
if length(loc1)~=length(loc2)
    return
end
number=loc2-loc1; %两个作为起降点的货车中间的货车数
index=floor(1+number*rand); %挑选其中的倒数第index个点作为待交换点
if  number==0 
    return;
else
    df=d(patht(loc1),patht(loc2))+d(patht(loc2-index),patht(loc2+1))+dd(pathd(k(i)-1),patht(loc2-index))...
        -d(patht(loc1),patht(loc2-index))-d(patht(loc2),patht(loc2+1))-dd(pathd(k(i)-1),patht(loc2));  %节点交换下的成本节省值
end
if length(patht(loc2-index))~=length(pathd(k(i)))
    return;
end
if df<0  %更新货车、无人机路径
    pathd(k(i))=patht(loc2-index);
    pathd(k(i)+1)=patht(loc2-index);
    mid=patht(loc2);
    patht(loc2)=patht(loc2-index);
    patht(loc2-index)=mid;
% elseif  exp(-df/T)>rand %更新货车、无人机路径
%     pathd(k(i))=patht(loc2-index);
%     pathd(k(i)+1)=patht(loc2-index);
%     mid=patht(loc2);
%     patht(loc2)=patht(loc2-index);
%     patht(loc2-index)=mid;
end