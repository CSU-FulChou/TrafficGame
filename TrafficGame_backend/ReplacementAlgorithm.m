%�滻�㷨
function [patht,pathd,M,k,N,long1,save_rate1]=ReplacementAlgorithm(path,d,dd,weight,longdmax,Gdmax,a,long0,sj1)
patht=path; %��¼����·��patht
pathd=[];   %��¼���˻�·��pathd
i=2;        %�ӵڶ��㿪ʼΪ�˿͵㣬��һ��Ϊ�ֿ�
M=[];       %�洢�˹���ǵ��λ��
while i<=101
    deltad=dd(path(i-1),path(i))+dd(path(i),path(i+1))+d(path(i-1),path(i+1))-d(path(i-1),path(i))-d(path(i),path(i+1)) ; %��ʼ�滻�ĳɱ�����ֵ����Ϊ�������滻��
    md=d(path(i-1),path(i))+d(path(i),path(i+1)); %���˻���ʼ���о���
    mt=d(path(i-1),path(i+1)); %������ʼ��ʻ����
    Gd=weight(path(i));  %���˻���ʼ������
    j=i-1;               %��¼�ϴγ�����ϵ�����
    if deltad<0 & md<=longdmax & Gd<=Gdmax & ~(any(i==a)) %�滻����������Լ��
        if sum(pathd)~=0 %�жϾ���ǿ�
            if path(i-1)~=pathd(end) %��������ɵ㲻��ͬһ��
                pathd=[pathd pathd(end)]; %�ظ���¼���һ����(�����)����һ����Ϊ��ɵ�
                M=[M length(pathd)]; %��¼�˹��ظ����λ��
            end
        end
        pathd=[pathd path(i-1)]; %��¼���˻���ɵ�
    end
    while deltad<0 & md<=longdmax & Gd<=Gdmax & ~(any(i==a))
        patht(i)=0;            %�����滻�Ŀ�������Ϊ0���˴������վ�������Ϊ��Ҫ��i����
        pathd=[pathd path(i)]; %���滻��������˻�·��
        i=i+1;    %������һ����
        if i>=102 %�ѱ��������е㣬����ѭ��
            break
        end
        deltad=dd(path(i),path(i+1))+d(path(j),path(i+1))-d(path(j),path(i))-d(path(i),path(i+1)); %�����滻�ĳɱ�����ֵ����Ϊ�������滻��
        md=md+d(path(i),path(i+1)); %���㱾�κ������˻��ۻ����о���
        Gd=Gd+weight(path(i));
    end
    if i>j+1 %֤�����ܹ������whileѭ��������ģ���i��Ϊ������ϵ㣬���������˻��ڳ����ߵ�
        pathd=[pathd path(i)]; %�ѽ����������˻�·��,�����ظ���
    end
    i=i+1; %������һ����
end
patht(find(patht==0))=[];
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
longdd=0; %��Ľ������˻����гɱ�
exlongdd=0; %���˻��복ͬ�еĳɱ�����ʱ���˻����ɣ�
for i=1:length(M)
    exlongdd=exlongdd+dd(pathd(M(i)),pathd(M(i)+1));
end
for nd=1:length(pathd)-1
    longdd=longdd+dd(pathd(nd),pathd(nd+1));
end
longdd=longdd-exlongdd;
%��������˻�����·���ľ��볤
longt=0;
for nt=1:length(patht)-1
    longt=longt+d(patht(nt),patht(nt+1));
end
long1=longdd+longt;                %���ܳ���long
save_rate1=(long0-long1)/long0;    %���ʡ·���ı�
xxt=sj1(patht,1);yyt=sj1(patht,2);
xxd=sj1(pathd,1);yyd=sj1(pathd,2);
xxG=sj1(path(a),1);yyG=sj1(path(a),2);
% plot(xxt,yyt,'-*',xxd,yyd,'r--o',xxG,yyG,'r*') %����Ѳ��·��
% xlabel('����')
% ylabel('γ��')
% title('����Эͬ��ʼ·��')
% legend('��������·��','���˻�����·��')
% figure;