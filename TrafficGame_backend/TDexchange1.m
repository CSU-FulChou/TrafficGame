% �����ظ����йصĳ����任
function [patht,pathd,k]=TDexchange1(patht,pathd,d,dd,weight,longdmax,Gdmax,k,M,N,a,T)
k=[]; % k��¼ͬ���𽵵�
for i=1:length(pathd)-1     %i��pathd�����
    if pathd(i)==pathd(i+1) %��������ظ�ֵ
        k=[k i];            %��k�����¼�ظ�������
    end
end
N=[]; % ɸѡ�����˹��ظ���
for i=1:length(k)
    if ~any(k(i)==M-1)
        N=[N k(i)];
    end
end
sdrone1=0;sdrone2=0;mdrone1=0;mdrone2=0;
randN=floor(1+length(N)*rand);
indk=find(N(randN)==k); %��ȡһ�����˹����ظ���(k�����)
if indk~=1 & indk~=length(k) & ~any(pathd(k(indk))==a)
    if any(k(indk-1)==M-1) %���ǰһ�������˹��ظ���
        randk=floor(length([k(indk-1)+3:k(indk+1)-1])*rand); %����ɵ��һ���� �� ���˻����´ν����ǰһ����ĵ�ĸ������������
        loc1=k(indk-1)+3+randk; %��¼�ö�������ɵ��pathd���(�õ㽫�������м��ظ������λ�ý���)
        loc2=k(indk); %indk��Ӧ�ķ��˹��ظ����pathd���
        loc0=k(indk-1)+2; loct=k(indk+1); %ǰ����һ���𽵵��λ��
    else
        randk=floor(length([k(indk-1)+2:k(indk+1)-1])*rand);
        loc1=k(indk-1)+2+randk; %��¼�ö�������ɵ�����(�õ㽫�������м��ظ������λ�ý���)
        loc2=k(indk); %indk��Ӧ�ķ��˹��ظ����λ��
        loc0=k(indk-1)+1; loct=k(indk+1); %ǰ����һ���𽵵��λ��
    end
    dcost=d(pathd(loc0),pathd(loc1))+d(pathd(loc1),pathd(loct))+dd(pathd(loc2-1),pathd(loc1))+dd(pathd(loc1),pathd(loc2+2))...
        -d(pathd(loc0),pathd(loc2))-d(pathd(loc2),pathd(loct))-dd(pathd(loc2-1),pathd(loc2))-dd(pathd(loc2),pathd(loc2+2));
    if dcost<0 | exp(-dcost/T)>rand %����ɱ����ͻ���ʽ���׼��֮һ������λ�ý���
        midt1=pathd(loc1);
        midt2=pathd(loc2); %���˹��ظ����λ�õĹ˿͵�
        patht(find(midt2==patht))=midt1;
        mid=pathd(loc1);
        pathd(loc1)=pathd(loc2);
        pathd(loc2)=mid;
        pathd(loc2+1)=mid;
        for i=loc0:loc2-1 %��任�����˻��ĵ�һ�κ���
            sdrone1=sdrone1+dd(pathd(i),pathd(i+1));
        end
        for i=loc2:loct-1 %��任�����˻��ĵڶ��κ���
            sdrone2=sdrone2+dd(pathd(i),pathd(i+1));
        end
        for i=loc0+1:loc2-1 %��任�����˻��ĵ�һ������
            mdrone1=mdrone1+weight(pathd(i));
        end
        for i=loc2+1:loct-1 %��任�����˻��ĵ�һ������
            mdrone2=mdrone2+weight(pathd(i));
        end
        if sdrone1>longdmax | sdrone2>longdmax | mdrone1>Gdmax | mdrone2>Gdmax %�����������һԼ���ٱ�һ�λָ�ԭ��
            midt1=pathd(loc1); %���ڽ��������˻��˿͵�
            midt2=pathd(loc2); %���˹��ظ���λ�õĹ˿͵�
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
        N=[]; % ɸѡ�����˹��ظ���
        for i=1:length(k)
            if ~any(k(i)==M-1)
                N=[N k(i)];
            end
        end
    end
end