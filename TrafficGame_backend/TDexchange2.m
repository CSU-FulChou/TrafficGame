% �˹��ظ����йصĳ����任
function [patht,pathd]=TDexchange2(path,patht,pathd,d,dd,weight,longdmax,Gdmax,k,M,a,T)
for i=1:length(k)
    if i==1  %�����׶����˻��ķ���
        Sd=0;
        if pathd(1)~=path(1) & any(k(1)+1==M) & ~any(pathd(1)==a) & ~any(pathd(k(1))==a)  %�жϵ�һ�����˻����еĽ�������������˻��𽵡��ҷ�����㲻�ǲֿ�ԭ�㡢����뽵���Ϊ�����
            for I=1:k(1)-1 %�����һ�����˻����е��ܺ�  ����Ϊ���˻��ķ��о���
                Sd=Sd+dd(pathd(I),pathd(I+1)); %����Ϊ���˻��ĺ���
            end
            St=d(pathd(1),pathd(k(1))); %�����һ�����˻�����ʱ�������ܺ�
            Gd=sum(weight(pathd(2:k(1)-1))); %�����һ�����˻������е�����
            % ���¿��ǵ�һ�η��е����ͷ����м����ж��任
            c=[1 floor(2+(k(1)-2)*rand(1))];
            dSt=d(pathd(c(2)),pathd(k(1)))+d(patht(find(patht==pathd(1))-1),pathd(c(2)))-d(patht(find(patht==pathd(1))-1),pathd(1))-d(pathd(1),pathd(k(1)));
            dSd=dd(1,pathd(c(2)+1))-dd(pathd(c(2)),pathd(c(2)+1));
            dS=dSt+dSd; %�任������ܺı仯����ĩ������
            Gd=Gd-weight(pathd(c(2)))+weight(pathd(1)); %�任������˻�����
            Sd=(Sd+dSd)*25; %�任������˻��ĺ���
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(1)))=pathd(c(2)); %���¿���·��
                pathd(1:k(i))=[pathd(c(2):-1:1),pathd(c(2)+1:k(1))]; %�������˻�·��
            end
            % ���¿��ǵ�һ�η��е��м��ͷ����յ���ж��任
            c=[floor(2+(k(1)-2)*rand(1)) k(1)];
            dSt=d(pathd(1),pathd(c(1)))+d(pathd(c(1)),patht(find(patht==pathd(k(1)))+1))-d(pathd(k(1)),patht(find(patht==pathd(k(1)))+1))-d(pathd(1),pathd(k(1)));
            dSd=dd(pathd(c(1)-1),pathd(k(1)))-dd(pathd(c(1)-1),pathd(c(1)));
            dS=dSt+dSd; %�任������ܺı仯����ĩ������
            Gd=Gd-weight(pathd(c(1)))+weight(pathd(k(1))); %�任������˻�����
            Sd=(Sd+dSd)*25;  %�任������˻��ĺ���
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(1))))=pathd(c(1));%���¿���·��
                pathd(1:k(i))=[pathd(1:c(1)-1),pathd(k(1):-1:c(1))];% �������˻�·��
                pathd(k(i)+1)=pathd(k(i)); %�����ظ���
            end
            % ���¿��ǵ�һ�η��е����ͷ����յ���ж��任
            dSt=d(patht(find(patht==pathd(1))-1),pathd(k(1)))+d(pathd(1),patht(find(patht==pathd(k(1)))+1))-d(patht(find(patht==pathd(1))-1),pathd(1))-d(pathd(k(1)),patht(find(patht==pathd(k(1)))+1));
            dSd=0;
            dS=dSt+dSd; %�任������ܺı仯����ĩ������
            Gd=Gd; %�任������˻�����Ϊ0
            Sd=(Sd+dSd)*25; %�任������˻��ĺ���
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(1)))=pathd(k(1));
                patht(find(patht==pathd(k(1))))=pathd(1);  %���¿���·��
                pathd(1:k(1))=pathd(k(1):-1:1);% �������˻�·��
                pathd(k(i)+1)=pathd(k(i)); %�����ظ���
            end
        end
    elseif  i==length(k)  %�������һ�����˻��ķ���
        Sd=0;
        if pathd(end)~=path(end) & any(k(i)+1==M) & ~any(pathd(k(i)+2)==a) & ~any(pathd(end)==a)  %�ж����һ�����˻����е���ɵ�û�б�����˻����䡢�ҷ����յ㲻�ǲֿ��յ㡢����뽵���Ϊ�����
            for I=k(i)+2:length(pathd)-1   %�������һ�����˻����е��ܺ�  ����Ϊ���˻��ķ��о���
                Sd=Sd+dd(pathd(I),pathd(I+1));   %����Ϊ���˻��ĺ���
            end
            St=d(pathd(k(i)+2),pathd(end)); %�������һ�����˻�����ʱ�������ܺ�
            Gd=sum(weight(pathd(k(i)+2:end)));%�����һ�����˻������е�����
            % �������һ�η��е����ͷ����м����ж��任
            c=[k(i)+2  floor(k(i)+3+(length(pathd)-k(i)-3)*rand(1))];
            dSt=d(pathd(c(2)),pathd(end))+d(patht(find(patht==pathd(k(i)+2-1))),pathd(c(2)))-d(patht(find(patht==pathd(k(i)+2-1))),pathd(k(i)+2))-d(pathd(k(i)+2),pathd(end));
            dSd=dd(pathd(k(i)+2),pathd(c(2)+1))-dd(pathd(c(2)),pathd(c(2)+1));
            dS=dSt+dSd; %�任������ܺı仯����ĩ������
            Gd=Gd-weight(pathd(c(2)))+weight(pathd(k(i)+2)); %�任������˻�����
            Sd=(Sd+dSd)*25; %�任������˻��ĺ���
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(i)+2)))=pathd(c(2));%���¿���·��
                pathd(k(i)+2:end)=[pathd(c(2):-1:k(i)+2),pathd(c(2)+1:end)];% �������˻�·��
            end
            % �������һ�η��еķ����м����յ���ж��任
            c=[floor(k(i)+3+(length(pathd)-k(i)-3)*rand(1))  length(pathd)];
            dSt=d(pathd(k(i)+2),pathd(c(1)))+d(pathd(c(1)),patht(find(patht==pathd(end))+1))-d(pathd(k(i)+2),pathd(end))-d(pathd(end),patht(find(patht==pathd(end))+1));
            dSd=dd(pathd(c(1)-1),pathd(end))-dd(pathd(c(1)-1),pathd(c(1)));
            dS=dSt+dSd; %�任������ܺı仯����ĩ������
            Gd=Gd-weight(pathd(c(1)))+weight(pathd(end)); %�任������˻�����
            Sd=(Sd+dSd)*25; %�任������˻��ĺ���
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(end)))=pathd(c(1));%���¿���·��
                pathd(k(i)+2:end)=[pathd(k(i)+2:c(1)-1),pathd(end:-1:c(1))];% �������˻�·��
            end
            % ���¿������һ�η��е����ͷ����յ���ж��任
            dSt=d(patht(find(patht==pathd(k(i)+2))-1),pathd(end))+d(pathd(k(i)+2),patht(find(patht==pathd(end))+1))-d(patht(find(patht==pathd(k(i)+2))-1),pathd(k(i)+2))-d(pathd(end),patht(find(patht==pathd(end))+1));
            dSd=0;
            dS=dSt+dSd; %�任������ܺı仯����ĩ������
            Gd=Gd; %�任������˻�����Ϊ0
            Sd=(Sd+dSd)*25; %�任������˻��ĺ���
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(i)+2)))=pathd(end); %���¿���·��
                patht(find(patht==pathd(end)))=pathd(k(i)+2);
                pathd(k(i)+2:end)=pathd(end:-1:k(i)+2);% �������˻�·��
            end
        end
    else  %����ĩ�ε��м䲿�ַ������������˻����ж�
        Sd=0;
        if  any(k(i)+1==M) & any(k(i+1)+1==M) & ~any(pathd(k(i)+2)==a) & ~any(pathd(k(i+1))==a)  %�ж��м�����˻����е����ͽ����������˹��ظ��㡢����뽵���Ϊ�����
            for I=k(i)+2:k(i+1)-1   %����ö����˻����е��ܺ�  ����Ϊ���˻��ķ��о���
                Sd=dd(pathd(I),pathd(I+1));   %����Ϊ���˻��ĺ���
            end
            St=d(pathd(k(i)+2),pathd(k(i+1))); %����ö����˻�����ʱ�������ܺ�
            Gd=sum(weight(pathd(k(i)+3:k(i+1)-1)));%�����һ�����˻������е�����
            % ���¿����м�öη��е����ͷ����м����ж��任
            c=[k(i)+2  floor(k(i)+3+(k(i+1)-k(i)-3)*rand(1))];
            dSt=d(patht(find(patht==pathd(k(i)+2))-1),pathd(c(2)))+d(pathd(c(2)),pathd(k(i+1)))-d(pathd(k(i)+2),pathd(k(i+1)))-d(patht(find(patht==pathd(k(i)+2))-1),pathd(k(i)+2));
            dSd=dd(pathd(k(i)+2),pathd(c(2)+1))-dd(pathd(c(2)),pathd(c(2)+1));
            dS=dSt+dSd; %�任������ܺı仯����ĩ������
            Gd=Gd-weight(pathd(c(2)))+weight(pathd(k(i)+2)); %�任������˻�����
            Sd=(Sd+dSd)*25; %�任������˻��ĺ���
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(i)+2)))=pathd(c(2));%���¿���·��
                pathd(k(i)+2:k(i+1))=[pathd(c(2):-1:k(i)+2),pathd(c(2)+1:k(i+1))];% �������˻�·��
            end
            % ���¿����м�öη��еķ����м����յ���ж��任
            c=[floor(k(i)+3+(k(i+1)-k(i)-3)*rand(1)) k(i+1)];
            dSt=d(pathd(k(i)+2),pathd(c(1)))+d(pathd(c(1)),patht(find(patht==pathd(k(i+1)))+1))-d(pathd(k(i+1)),patht(find(patht==pathd(k(i+1)))+1))-d(pathd(k(i)+2),pathd(k(i+1)));
            dSd=dd(pathd(c(1)-1),pathd(k(i+1)))-dd(pathd(c(1)-1),pathd(c(1)));
            dS=dSt+dSd; %�任������ܺı仯����ĩ������
            Gd=Gd-weight(pathd(c(1)))+weight(pathd(k(i+1))); %�任������˻�����
            Sd=(Sd+dSd)*25; %�任������˻��ĺ���
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(i+1))))=pathd(c(1));%���¿���·��
                pathd(k(i)+2:k(i+1))=[pathd(k(i)+2:c(1)-1),pathd(k(i+1):-1:c(1))];% �������˻�·��
                pathd(k(i+1)+1)=pathd(k(i+1));
            end
            % ���¿����м�öη��е����ͷ����յ���ж��任
            dSt=d(patht(find(patht==pathd(k(i)+2))-1),pathd(k(i+1)))+d(pathd(k(i)+2),patht(find(patht==pathd(k(i+1)))+1))-d(patht(find(patht==pathd(k(i)+2))-1),pathd(k(i)+2))-d(pathd(k(i+1)),patht(find(patht==pathd(k(i+1)))+1));
            dSd=0;
            dS=dSt+dSd; %�任������ܺı仯����ĩ������
            Gd=Gd; %�任������˻�����Ϊ0
            Sd=(Sd+dSd)*25; %�任������˻��ĺ���
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(i)+2)))=pathd(k(i+1));
                patht(find(patht==pathd(k(i+1))))=pathd(k(i)+2);  %���¿���·��
                pathd(k(i)+2:k(i+1))=pathd(k(i+1):-1:k(i)+2);% �������˻�·��
                pathd(k(i+1)+1)=pathd(k(i+1));
            end
        end
    end
end