% �������Эͬ·���ͳɱ�ʹ�������������ʾ��ͼ
function [patht,xxt,yyt,pathd,xxd,yyd,xxG,yyG,long,save_ratefor0,save_ratefor1]=PrintAndPlot(path,patht,pathd,sj1,M,a,d,dd,long0,long1)
% ����ʾ��ͼ
xxt=sj1(patht,1);yyt=sj1(patht,2);
xxd=sj1(pathd,1);yyd=sj1(pathd,2);
xxG=sj1(path(a),1);yyG=sj1(path(a),2);
plot(xxt,yyt,'-*',xxd,yyd,'r--o',xxG,yyG,'r*') %����Ѳ��·��
title('����Эͬ�Ż�·��')
legend('��������·��','���˻�����·��')
% ��ɱ���ʡ�ı���
longdd=0;   %��Ľ������˻����гɱ�
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
long=longdd+longt; %���ܳ���long
save_ratefor0=(long0-long)/long0*100;  %��Ի����������͵ĳɱ���ʡ��
save_ratefor1=(long1-long)/long1*100;  %��Գ�ʼ��ĳɱ���ʡ��
fprintf('����Эͬ����·�����£�\n');
fprintf('����·��Ϊ��\n');
disp(patht);
fprintf('���˻�·��Ϊ��\n');
disp(pathd);
fprintf('�������������ܳɱ���%.2fԪ\n',long0);
fprintf('��ʼ��������ܳɱ���%.2fԪ\n',long1);
fprintf('����Эͬ�����ܳɱ���%.2fԪ\n',long);
fprintf('�Ȼ����������ͽ�ʡ��%.2f%%\n',save_ratefor0);
fprintf('�ȳ�ʼЭͬ���ͽ�ʡ��%.2f%%\n',save_ratefor1);
% repeat1=[];
% repeat2=[];
% for i=1:length(M)
%     if find(path==pathd(M(i)+1))-find(path==pathd(M(i)))~=1
%         repeat1=[repeat1 pathd(M(i)) pathd(M(i)+1)];          %ɸѡ����һ�����˻������ĺ󼸸���Ϊ��һ�����˻���ɵ�
%     else
%         repeat2=[repeat2 pathd(M(i)) pathd(M(i)+1)];          %ɸѡ����һ�����˻������ĺ�һ����Ϊ��һ�����˻���ɵ�
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