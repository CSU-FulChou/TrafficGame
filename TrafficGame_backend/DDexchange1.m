% �����任����ȫ�ֶ��任
function [pathd]=DDexchange1(patht,pathd,k,d,dd,M,T,weight,longdmax,Gdmax)
index=1:length(pathd); %pathdd�����
index([1,k,end])=[];
c=floor(1+length(index)*rand(1,2));
c=sort(c);c1=index(c(1));c2=index(c(2));
%������ۺ���ֵ������
if c2-c1==1 %���ڵ�任�Ĵ��ۺ���
    df=dd(pathd(c1-1),pathd(c2))+dd(pathd(c1),pathd(c2+1))-dd(pathd(c1-1),pathd(c1))-dd(pathd(c2),pathd(c2+1));
else  %�����ڵ�任�Ĵ��ۺ���
    df=dd(pathd(c1-1),pathd(c2))+dd(pathd(c2),pathd(c1+1))+dd(pathd(c2-1),pathd(c1))+dd(pathd(c1),pathd(c2+1))...
        -(dd(pathd(c1-1),pathd(c1))+dd(pathd(c1),pathd(c1+1))+dd(pathd(c2-1),pathd(c2))+dd(pathd(c2),pathd(c2+1)));
end
%ɾ�����е����˻��𽵵�
if any(c1==[k+1,M+1] | c2==[k+1,M+1])
    return;
end
%����׼��
if df<0 | exp(-df/T)>rand
    % ����任
    bridge=pathd(c1);
    pathd(c1)=pathd(c2);
    pathd(c2)=bridge;
    % �жϸ�����任���Ƿ�����Լ��
    loc1=find(k>c1);loc2=find(k>c2);
    sd1=0;sd2=0;wd1=0;wd2=0;
    if sum(loc1)==0
        for i=k(end):length(pathd)-1
            sd1=sd1+dd(pathd(i),pathd(i+1));
            wd1=wd1+weight(pathd(i));
        end
        wd1=wd1-weight(pathd(k(end)));
    elseif loc1(1)-1==0
        for i=1:k(loc1(1))-1
            sd1=sd1+dd(pathd(i),pathd(i+1));
            wd1=wd1+weight(pathd(i));
        end
        wd1=wd1-weight(pathd(k(1)));
    else
        for i=k(loc1(1)-1):k(loc1(1))-1
            sd1=sd1+dd(pathd(i),pathd(i+1));
            wd1=wd1+weight(pathd(i));
        end
        wd1=wd1-weight(pathd(k(loc1(1)-1)));
    end
    if sum(loc2)==0
        for i=k(end):length(pathd)-1
            sd2=sd2+dd(pathd(i),pathd(i+1));
            wd2=wd2+weight(pathd(i));
        end
        wd2=wd2-weight(pathd(k(end)));
    elseif loc2(1)-1==0
        for i=1:k(loc2(1))-1
            sd2=sd2+dd(pathd(i),pathd(i+1));
            wd2=wd2+weight(pathd(i));
        end
        wd2=wd2-weight(pathd(k(1)));
    else
        for i=k(loc2(1)-1):k(loc2(1))-1
            sd2=sd2+dd(pathd(i),pathd(i+1));
            wd2=wd2+weight(pathd(i));
        end
        wd2=wd2-weight(pathd(k(loc2(1)-1)));
    end
    if sd1 > longdmax | wd1 > Gdmax | sd2 > longdmax | wd2 > Gdmax
        bridge=pathd(c1);
        pathd(c1)=pathd(c2);
        pathd(c2)=bridge;
    end 
end
