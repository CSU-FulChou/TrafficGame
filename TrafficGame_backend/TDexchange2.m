% 人工重复点有关的车机变换
function [patht,pathd]=TDexchange2(path,patht,pathd,d,dd,weight,longdmax,Gdmax,k,M,a,T)
for i=1:length(k)
    if i==1  %考虑首段无人机的飞行
        Sd=0;
        if pathd(1)~=path(1) & any(k(1)+1==M) & ~any(pathd(1)==a) & ~any(pathd(k(1))==a)  %判断第一段无人机飞行的降落点无其它无人机起降、且飞行起点不是仓库原点、起飞与降落点为轻货物
            for I=1:k(1)-1 %计算第一次无人机飞行的能耗  可视为无人机的飞行距离
                Sd=Sd+dd(pathd(I),pathd(I+1)); %可视为无人机的航程
            end
            St=d(pathd(1),pathd(k(1))); %计算第一次无人机飞行时卡车的能耗
            Gd=sum(weight(pathd(2:k(1)-1))); %计算第一段无人机飞行中的载重
            % 以下考虑第一次飞行的起点和飞行中间点进行二变换
            c=[1 floor(2+(k(1)-2)*rand(1))];
            dSt=d(pathd(c(2)),pathd(k(1)))+d(patht(find(patht==pathd(1))-1),pathd(c(2)))-d(patht(find(patht==pathd(1))-1),pathd(1))-d(pathd(1),pathd(k(1)));
            dSd=dd(1,pathd(c(2)+1))-dd(pathd(c(2)),pathd(c(2)+1));
            dS=dSt+dSd; %变换后的总能耗变化量（末减初）
            Gd=Gd-weight(pathd(c(2)))+weight(pathd(1)); %变换后的无人机载重
            Sd=(Sd+dSd)*25; %变换后的无人机的航程
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(1)))=pathd(c(2)); %更新卡车路径
                pathd(1:k(i))=[pathd(c(2):-1:1),pathd(c(2)+1:k(1))]; %更新无人机路径
            end
            % 以下考虑第一次飞行的中间点和飞行终点进行二变换
            c=[floor(2+(k(1)-2)*rand(1)) k(1)];
            dSt=d(pathd(1),pathd(c(1)))+d(pathd(c(1)),patht(find(patht==pathd(k(1)))+1))-d(pathd(k(1)),patht(find(patht==pathd(k(1)))+1))-d(pathd(1),pathd(k(1)));
            dSd=dd(pathd(c(1)-1),pathd(k(1)))-dd(pathd(c(1)-1),pathd(c(1)));
            dS=dSt+dSd; %变换后的总能耗变化量（末减初）
            Gd=Gd-weight(pathd(c(1)))+weight(pathd(k(1))); %变换后的无人机载重
            Sd=(Sd+dSd)*25;  %变换后的无人机的航程
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(1))))=pathd(c(1));%更新卡车路径
                pathd(1:k(i))=[pathd(1:c(1)-1),pathd(k(1):-1:c(1))];% 更新无人机路径
                pathd(k(i)+1)=pathd(k(i)); %更新重复点
            end
            % 以下考虑第一次飞行的起点和飞行终点进行二变换
            dSt=d(patht(find(patht==pathd(1))-1),pathd(k(1)))+d(pathd(1),patht(find(patht==pathd(k(1)))+1))-d(patht(find(patht==pathd(1))-1),pathd(1))-d(pathd(k(1)),patht(find(patht==pathd(k(1)))+1));
            dSd=0;
            dS=dSt+dSd; %变换后的总能耗变化量（末减初）
            Gd=Gd; %变换后的无人机载重为0
            Sd=(Sd+dSd)*25; %变换后的无人机的航程
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(1)))=pathd(k(1));
                patht(find(patht==pathd(k(1))))=pathd(1);  %更新卡车路径
                pathd(1:k(1))=pathd(k(1):-1:1);% 更新无人机路径
                pathd(k(i)+1)=pathd(k(i)); %更新重复点
            end
        end
    elseif  i==length(k)  %考虑最后一段无人机的飞行
        Sd=0;
        if pathd(end)~=path(end) & any(k(i)+1==M) & ~any(pathd(k(i)+2)==a) & ~any(pathd(end)==a)  %判断最后一段无人机飞行的起飞点没有别的无人机降落、且飞行终点不是仓库终点、起飞与降落点为轻货物
            for I=k(i)+2:length(pathd)-1   %计算最后一次无人机飞行的能耗  可视为无人机的飞行距离
                Sd=Sd+dd(pathd(I),pathd(I+1));   %可视为无人机的航程
            end
            St=d(pathd(k(i)+2),pathd(end)); %计算最后一次无人机飞行时卡车的能耗
            Gd=sum(weight(pathd(k(i)+2:end)));%计算第一段无人机飞行中的载重
            % 考虑最后一次飞行的起点和飞行中间点进行二变换
            c=[k(i)+2  floor(k(i)+3+(length(pathd)-k(i)-3)*rand(1))];
            dSt=d(pathd(c(2)),pathd(end))+d(patht(find(patht==pathd(k(i)+2-1))),pathd(c(2)))-d(patht(find(patht==pathd(k(i)+2-1))),pathd(k(i)+2))-d(pathd(k(i)+2),pathd(end));
            dSd=dd(pathd(k(i)+2),pathd(c(2)+1))-dd(pathd(c(2)),pathd(c(2)+1));
            dS=dSt+dSd; %变换后的总能耗变化量（末减初）
            Gd=Gd-weight(pathd(c(2)))+weight(pathd(k(i)+2)); %变换后的无人机载重
            Sd=(Sd+dSd)*25; %变换后的无人机的航程
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(i)+2)))=pathd(c(2));%更新卡车路径
                pathd(k(i)+2:end)=[pathd(c(2):-1:k(i)+2),pathd(c(2)+1:end)];% 更新无人机路径
            end
            % 考虑最后一次飞行的飞行中间点和终点进行二变换
            c=[floor(k(i)+3+(length(pathd)-k(i)-3)*rand(1))  length(pathd)];
            dSt=d(pathd(k(i)+2),pathd(c(1)))+d(pathd(c(1)),patht(find(patht==pathd(end))+1))-d(pathd(k(i)+2),pathd(end))-d(pathd(end),patht(find(patht==pathd(end))+1));
            dSd=dd(pathd(c(1)-1),pathd(end))-dd(pathd(c(1)-1),pathd(c(1)));
            dS=dSt+dSd; %变换后的总能耗变化量（末减初）
            Gd=Gd-weight(pathd(c(1)))+weight(pathd(end)); %变换后的无人机载重
            Sd=(Sd+dSd)*25; %变换后的无人机的航程
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(end)))=pathd(c(1));%更新卡车路径
                pathd(k(i)+2:end)=[pathd(k(i)+2:c(1)-1),pathd(end:-1:c(1))];% 更新无人机路径
            end
            % 以下考虑最后一次飞行的起点和飞行终点进行二变换
            dSt=d(patht(find(patht==pathd(k(i)+2))-1),pathd(end))+d(pathd(k(i)+2),patht(find(patht==pathd(end))+1))-d(patht(find(patht==pathd(k(i)+2))-1),pathd(k(i)+2))-d(pathd(end),patht(find(patht==pathd(end))+1));
            dSd=0;
            dS=dSt+dSd; %变换后的总能耗变化量（末减初）
            Gd=Gd; %变换后的无人机载重为0
            Sd=(Sd+dSd)*25; %变换后的无人机的航程
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(i)+2)))=pathd(end); %更新卡车路径
                patht(find(patht==pathd(end)))=pathd(k(i)+2);
                pathd(k(i)+2:end)=pathd(end:-1:k(i)+2);% 更新无人机路径
            end
        end
    else  %除首末段的中间部分符合条件的无人机飞行段
        Sd=0;
        if  any(k(i)+1==M) & any(k(i+1)+1==M) & ~any(pathd(k(i)+2)==a) & ~any(pathd(k(i+1))==a)  %判断中间段无人机飞行的起点和降落点均碰到人工重复点、起飞与降落点为轻货物
            for I=k(i)+2:k(i+1)-1   %计算该段无人机飞行的能耗  可视为无人机的飞行距离
                Sd=dd(pathd(I),pathd(I+1));   %可视为无人机的航程
            end
            St=d(pathd(k(i)+2),pathd(k(i+1))); %计算该段无人机飞行时卡车的能耗
            Gd=sum(weight(pathd(k(i)+3:k(i+1)-1)));%计算第一段无人机飞行中的载重
            % 以下考虑中间该段飞行的起点和飞行中间点进行二变换
            c=[k(i)+2  floor(k(i)+3+(k(i+1)-k(i)-3)*rand(1))];
            dSt=d(patht(find(patht==pathd(k(i)+2))-1),pathd(c(2)))+d(pathd(c(2)),pathd(k(i+1)))-d(pathd(k(i)+2),pathd(k(i+1)))-d(patht(find(patht==pathd(k(i)+2))-1),pathd(k(i)+2));
            dSd=dd(pathd(k(i)+2),pathd(c(2)+1))-dd(pathd(c(2)),pathd(c(2)+1));
            dS=dSt+dSd; %变换后的总能耗变化量（末减初）
            Gd=Gd-weight(pathd(c(2)))+weight(pathd(k(i)+2)); %变换后的无人机载重
            Sd=(Sd+dSd)*25; %变换后的无人机的航程
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(i)+2)))=pathd(c(2));%更新卡车路径
                pathd(k(i)+2:k(i+1))=[pathd(c(2):-1:k(i)+2),pathd(c(2)+1:k(i+1))];% 更新无人机路径
            end
            % 以下考虑中间该段飞行的飞行中间点和终点进行二变换
            c=[floor(k(i)+3+(k(i+1)-k(i)-3)*rand(1)) k(i+1)];
            dSt=d(pathd(k(i)+2),pathd(c(1)))+d(pathd(c(1)),patht(find(patht==pathd(k(i+1)))+1))-d(pathd(k(i+1)),patht(find(patht==pathd(k(i+1)))+1))-d(pathd(k(i)+2),pathd(k(i+1)));
            dSd=dd(pathd(c(1)-1),pathd(k(i+1)))-dd(pathd(c(1)-1),pathd(c(1)));
            dS=dSt+dSd; %变换后的总能耗变化量（末减初）
            Gd=Gd-weight(pathd(c(1)))+weight(pathd(k(i+1))); %变换后的无人机载重
            Sd=(Sd+dSd)*25; %变换后的无人机的航程
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(i+1))))=pathd(c(1));%更新卡车路径
                pathd(k(i)+2:k(i+1))=[pathd(k(i)+2:c(1)-1),pathd(k(i+1):-1:c(1))];% 更新无人机路径
                pathd(k(i+1)+1)=pathd(k(i+1));
            end
            % 以下考虑中间该段飞行的起点和飞行终点进行二变换
            dSt=d(patht(find(patht==pathd(k(i)+2))-1),pathd(k(i+1)))+d(pathd(k(i)+2),patht(find(patht==pathd(k(i+1)))+1))-d(patht(find(patht==pathd(k(i)+2))-1),pathd(k(i)+2))-d(pathd(k(i+1)),patht(find(patht==pathd(k(i+1)))+1));
            dSd=0;
            dS=dSt+dSd; %变换后的总能耗变化量（末减初）
            Gd=Gd; %变换后的无人机载重为0
            Sd=(Sd+dSd)*25; %变换后的无人机的航程
            if Sd<=longdmax & dS<=0 & Gd<=Gdmax
                patht(find(patht==pathd(k(i)+2)))=pathd(k(i+1));
                patht(find(patht==pathd(k(i+1))))=pathd(k(i)+2);  %更新卡车路径
                pathd(k(i)+2:k(i+1))=pathd(k(i+1):-1:k(i)+2);% 更新无人机路径
                pathd(k(i+1)+1)=pathd(k(i+1));
            end
        end
    end
end