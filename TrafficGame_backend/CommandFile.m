clc, clear, clf %����ϴ����к�������С���������ͼ��
tic %��ʼ��ʱ
sj0=load('sj.txt'); %���������ļ�����100��Ŀ��ľ�γ�ȣ�
% sj0=sj0(1:12,:);  %���������ģ
% weightdata=load('weight.mat');  %���ذ�������
% weight=weightdata.weight;       %������������
weight=[0,2.3*rand(1,100),0]; %�������100����������
vd=65;          %���˻��趨�ٶ�
vt=40;          %�������趨�ٶ�
Gdmax=10;       %���˻���������
longdmax=2500;  %���˻���������
a=find(weight>=2.3); %�ػ�������
TDrate=1/25;    %���˻�������ĳɱ���
[patht,pathd,long,save_ratefor0,save_ratefor1]=main(sj0,vd,vt,Gdmax,longdmax,weight,TDrate,a);
toc %��ʱ����