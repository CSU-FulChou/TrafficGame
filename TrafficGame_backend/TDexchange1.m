% 正常重复点有关的车机变换
function [patht,pathd,k]=TDexchange1(patht,pathd,d,dd,weight,longdmax,Gdmax,k,M,N,a,T)
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
sdrone1=0;sdrone2=0;mdrone1=0;mdrone2=0;
randN=floor(1+length(N)*rand);
indk=find(N(randN)==k); %任取一个非人工起降重复点(k的序号)
if indk~=1 & indk~=length(k) & ~any(pathd(k(indk))==a)
    if any(k(indk-1)==M-1) %如果前一个点是人工重复点
        randk=floor(length([k(indk-1)+3:k(indk+1)-1])*rand); %从起飞点后一个点 到 无人机下下次降落点前一个点的点的个数，进行随机
        loc1=k(indk-1)+3+randk; %记录该段随机生成点的pathd序号(该点将尝试与中间重复点进行位置交换)
        loc2=k(indk); %indk对应的非人工重复点的pathd序号
        loc0=k(indk-1)+2; loct=k(indk+1); %前（后）一个起降点的位置
    else
        randk=floor(length([k(indk-1)+2:k(indk+1)-1])*rand);
        loc1=k(indk-1)+2+randk; %记录该段随机生成点的序号(该点将尝试与中间重复点进行位置交换)
        loc2=k(indk); %indk对应的非人工重复点的位置
        loc0=k(indk-1)+1; loct=k(indk+1); %前（后）一个起降点的位置
    end
    dcost=d(pathd(loc0),pathd(loc1))+d(pathd(loc1),pathd(loct))+dd(pathd(loc2-1),pathd(loc1))+dd(pathd(loc1),pathd(loc2+2))...
        -d(pathd(loc0),pathd(loc2))-d(pathd(loc2),pathd(loct))-dd(pathd(loc2-1),pathd(loc2))-dd(pathd(loc2),pathd(loc2+2));
    if dcost<0 | exp(-dcost/T)>rand %满足成本降低或概率接受准则之一，进行位置交换
        midt1=pathd(loc1);
        midt2=pathd(loc2); %非人工重复点的位置的顾客点
        patht(find(midt2==patht))=midt1;
        mid=pathd(loc1);
        pathd(loc1)=pathd(loc2);
        pathd(loc2)=mid;
        pathd(loc2+1)=mid;
        for i=loc0:loc2-1 %求变换后无人机的第一段航程
            sdrone1=sdrone1+dd(pathd(i),pathd(i+1));
        end
        for i=loc2:loct-1 %求变换后无人机的第二段航程
            sdrone2=sdrone2+dd(pathd(i),pathd(i+1));
        end
        for i=loc0+1:loc2-1 %求变换后无人机的第一段载重
            mdrone1=mdrone1+weight(pathd(i));
        end
        for i=loc2+1:loct-1 %求变换后无人机的第一段载重
            mdrone2=mdrone2+weight(pathd(i));
        end
        if sdrone1>longdmax | sdrone2>longdmax | mdrone1>Gdmax | mdrone2>Gdmax %如果不满足任一约束再变一次恢复原样
            midt1=pathd(loc1); %用于交换的无人机顾客点
            midt2=pathd(loc2); %非人工重复点位置的顾客点
            patht(find(midt2==patht))=midt1;
            mid=pathd(loc1);
            pathd(loc1)=pathd(loc2);
            pathd(loc2)=mid;
            pathd(loc2+1)=mid;
        end
        k=[];
        for i=1:length(pathd)-1
            if pathd(i)==pathd(i+1)
                k=[k i];
            end
        end
        N=[]; % 筛选出非人工重复点
        for i=1:length(k)
            if ~any(k(i)==M-1)
                N=[N k(i)];
            end
        end
    end
end