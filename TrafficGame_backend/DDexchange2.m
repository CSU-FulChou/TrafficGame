% �����任����ɾ������
function [pathd,k,M]=DDexchange2(patht,pathd,k,d,dd,M,T,weight,longdmax,Gdmax)
for i=1:length(M)
    number(i)=find(M(i)-1==k); %��¼M��k��λ�ã�Ϊ���������ظ�����׼��
end
index=1:length(pathd); %pathd�����
index([1,k,end])=[];   %ɾ�����˻��𽵵�(��Ϊ���ڱ任�������ԣ������𽵵�����ų�)
c=floor(1+length(index)*rand(1,2)); %���ѡȡ�������˻��ڵ�
c=sort(c);c1=index(c(1));c2=index(c(2)); %����ɾ����Ϊ���С�Ľڵ㣬�����Ϊ��Ŵ�Ľڵ�
% �жϸ�����任���Ƿ�����Լ��
loc1=find(k>c1);loc2=find(k>c2); %��λc1��c2���ڶΣ�k(i)ǰ�ĶΣ�
sd1=0;sd2=0;wd1=0;wd2=0;
if sum(loc1)==0 %���ն�
    for i=k(end):length(pathd)-1
        sd1=sd1+dd(pathd(i),pathd(i+1));
        wd1=wd1+weight(pathd(i));
    end
    wd1=wd1-weight(pathd(k(end)));
elseif loc1(1)-1==0 %��ʼ��
    for i=1:k(loc1(1))-1
        sd1=sd1+dd(pathd(i),pathd(i+1));
        wd1=wd1+weight(pathd(i));
    end
    wd1=wd1-weight(pathd(k(1)));
else %�м��
    for i=k(loc1(1)-1):k(loc1(1))-1
        sd1=sd1+dd(pathd(i),pathd(i+1));
        wd1=wd1+weight(pathd(i));
    end
    wd1=wd1-weight(pathd(k(loc1(1)-1)));
end
if sum(loc2)==0 %���ն�
    for i=k(end):length(pathd)-1
        sd2=sd2+dd(pathd(i),pathd(i+1));
        wd2=wd2+weight(pathd(i));
    end
    wd2=wd2-weight(pathd(k(end)));
elseif loc2(1)-1==0 %��ʼ��
    for i=1:k(loc2(1))-1
        sd2=sd2+dd(pathd(i),pathd(i+1));
        wd2=wd2+weight(pathd(i));
    end
    wd2=wd2-weight(pathd(k(1)));
else %�м��
    for i=k(loc2(1)-1):k(loc2(1))-1
        sd2=sd2+dd(pathd(i),pathd(i+1));
        wd2=wd2+weight(pathd(i));
    end
    wd2=wd2-weight(pathd(k(loc2(1)-1)));
end
if sd1 > longdmax | wd1 > Gdmax | sd2 > longdmax | wd2 > Gdmax
    return;
end
% ������ۺ���ֵ������
if c2-c1==1 %��������
    df=dd(pathd(c1-1),pathd(c2))+dd(pathd(c1),pathd(c2+1))-dd(pathd(c1-1),pathd(c1))-dd(pathd(c2),pathd(c2+1));
else %����������
    df=dd(pathd(c1-1),pathd(c1+1))+dd(pathd(c2-1),pathd(c1))+dd(pathd(c1),pathd(c2))...
        -dd(pathd(c1-1),pathd(c1))-dd(pathd(c1),pathd(c1+1))-dd(pathd(c2-1),pathd(c2));
end
if any(c1==[k+1,M+1] | c2==[k+1,M+1])
    return; %ɾ�����е����˻��𽵵�
end
% ����׼��
if df<0
    pathd=pathd([1:c1-1,c1+1:c2,c1,c2+1:end]);
elseif exp(-df/T)>rand
    pathd=pathd([1:c1-1,c1+1:c2,c1,c2+1:end]);
end
% �޸��ظ���
k=[];
for i=1:length(pathd)-1
    if pathd(i)==pathd(i+1)
        k=[k i];
    end
end
M=k(number)+1;