% �����Ż���ɾ��-������ڵ㽻��
function patht=TTexchange1(patht,pathd,M,d,dd,T)
for i=1:length(M)         %�����˹��ظ�����Ѱ���������������
    number1=M(i)+1;       %���˻���ɵ����
    number2=find(patht==pathd(M(i)))+1;  %Ѱ�ҿ��������˻����е��ڲ� ����Ŀ�������ţ��ڿ���·�����е���ţ�
%     if length(number2)>1
%         M,patht,pathd,number2
%     end
    q=pathd(number1);
    if  patht(number2)~=q & length(patht)>=number2+1         %ɸѡ���ڵ��������˻�·������ڿ���������
        save1=d(patht(number2-2),patht(number2))+d(patht(number2-1),patht(number2+1))-d(patht(number2-2),patht(number2-1))-d(patht(number2),patht(number2+1)); %����ɾ���µĳɱ���ʡֵ
        save2=dd(pathd(M(i)-2),patht(number2))-dd(pathd(M(i)-2),pathd(M(i)-1));  %�ڵ㽻���µĳɱ���ʡֵ
        if save1<0 & save2-save1>0   %˵��ɾ�������ɱ�ֵ��ʡ��  ����Ҫ�ٽ��нڵ㽻��
            mid=patht(number2-1);
            patht(number2-1)=patht(number2);
            patht(number2)=mid;         %���¿���·���еĵ�
        elseif  save2<0 & save1-save2>0   %˵���ڵ㽻����ĳɱ�ֵ�ϴ�
            pathd(M(i))=patht(number2);
            pathd(M(i)-1)=patht(number2);    %�������˻�·���еĵ�
        end
    end
end