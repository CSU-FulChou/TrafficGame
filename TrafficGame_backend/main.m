%���������
%  sj0�˿͵ľ�γ�����ݣ�vd���˻����趨�ٶȣ�vt�������趨�ٶȣ�Gdmax���˻��������ޣ�
%  longdmax���˻��������ޣ�weight��������������TDrate���˻�������ĳɱ��ȣ�a�ػ�������
%���������
%  patht������·����pathd���˻���·����long����Эͬ���ͳɱ���
%  save_ratefor0������Эͬ��Ȼ����������͵ĳɱ���ʡ��
%  save_ratefor1������Эͬ��ȳ�ʼ��ĳɱ���Լ��
function [patht,pathd,long,save_ratefor0,save_ratefor1]=main(sj0,vd,vt,Gdmax,longdmax,weight,TDrate,a)
% Step1���Ŵ��㷨�������ŵĻ�����·��
[long0,path,d,dd,sj1]=GAInitial(sj0,TDrate);
% Step2���滻�㷨�������ֿ������滻Ϊ���˻��㣬�õ���ʼ����Эͬ·��
[patht,pathd,M,k,N,long1]=ReplacementAlgorithm(path,d,dd,weight,longdmax,Gdmax,a,long0,sj1);
% Step3��ģ���˻��㷨������Эͬ·���Ż�
e=0.1^30;L=200000;at=0.999;T=1; 
for i=1:L
    flag=floor(1+6*rand);
    switch flag
        case{1} % �����任���������ظ���
            [patht,pathd,k]=TDexchange1(patht,pathd,d,dd,weight,longdmax,Gdmax,k,M,N,a,T);
        case{2} % �����任�����˹��ظ���
            [patht,pathd]=TDexchange2(path,patht,pathd,d,dd,weight,longdmax,Gdmax,k,M,a,T);
        case{3} % �����任����ȫ�ֶ��任
            pathd=DDexchange1(patht,pathd,k,d,dd,M,T,weight,longdmax,Gdmax);
        case{4} % �����任����ɾ������
            [pathd,k,M]=DDexchange2(patht,pathd,k,d,dd,M,T,weight,longdmax,Gdmax);
        case{5} % �����任����ɾ������
            patht=TTexchange1(patht,pathd,M,d,dd,T);
        case{6} % �����任�������ڶ�����
            patht=TTexchange2(patht,pathd,k,M,d,dd,T);
    end
    T=T*at; %����0.999�Ľ���ϵ�����н���
    if T<e  %�ж��˻�����Ƿ����
        break;
    end
end
% Step4��������ͼ����������������Эͬ����·���뾭γ�ȣ�����ɱ�ʹ�����������ʾ��ͼ
[patht,xxt,yyt,pathd,xxd,yyd,xxG,yyG,long,save_ratefor0,save_ratefor1]=PrintAndPlot(path,patht,pathd,sj1,M,a,d,dd,long0,long1);
patht=[patht' xxt yyt]; 
pathd=[pathd' xxd yyd];
heavybag=[path(a)' xxG yyG];
% ��·���뾭γ�ȷŵ�ͬһ����