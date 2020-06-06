function [f_a,Alpha]=AlphaR(Data,rinterval,qinterval)
%[f_a,a]=AlphaR(Data,rinterval,qinterval)
%AlphaR为计算多重分形谱的函数
%Data为输入样本数据列向量第一列为数据
%rinterval为尺子取值范围rinterval=[rmin,rmax];
%rmin为大于等于2的正整数，最大为数据长度
%qinterval为q取值范围qinterval=[qmin,q步长,qmax];
%% 数据准备
L=length(Data); % 总数据个数

%尺子参数
rmin=rinterval(1);          % 尺子区间
rmax=rinterval(2);
rno=rmax-rmin+1;            % 尺子个数
%q参数
qmin=qinterval(1);          % q的范围
qd=qinterval(2);            % 步长
qmax=qinterval(3);
qno=fix((qmax-qmin)/qd+1);  % q的个数

c=zeros(rno,1);
i=1;
for r=rmin:rmax     % 每组区间长度
    c(i,1)=mod(L,r);
    i=i+1;
end
c=c';                 % 计算不能被边长r整除的余数
count=L-c;

format long
modify=1;
modifying=zeros(rno,1);
r=rmin;               % 尺子初始长度
%% 进入配分函数主循环
%计算每区间质量值
for i=1:rno
    B=Data(1:count(i),1);   % 取出每个尺子对应的所有数据
    ino=length(B)/r;  % 尺子对应的区间数interval no
    Tssum=sum(B);
    U=reshape(B,r,ino); % 每列保存每区间全部数据
    T=sum(U)./Tssum;  % 每个区间的质量
    T=T';
    TT(1:length(T),i)=T;  % 按列保存不同区间的T值%%%%%%%%%%%%preallocate
    modifying(modify,1)=ino; % 每个尺子对应区间数(T值的个数）
    r=r+1;
    if r>= rmin+rno   % 自定义项，“※-3”
        break;        % 边长初始限制，循环终止
    end
    modify=modify+1;
end

TT=nonzeros(TT);
to_modifying=zeros(rno,1);
for cugb=1:rno
    to_modifying(cugb,1)=sum(modifying(1:cugb)); % 第i个尺子累计有T值个数的总数
end

j=1;
% q 为任意数，这里取1到n，为n，与 k取值保持一致，q过大，计算机无法
%识别，默认为无穷大，q过小，结果接近0，则意义不明确
XX=zeros(rno,qno);
for q=qmin:qd:qmax
    for k=1:rno
        if k==1
            X=TT(1:to_modifying(k,1),1).^q;
        else
            X=TT(to_modifying(k-1,1)+1:to_modifying(k,1),1).^q;
        end
        t=sum(X);
        XX(k,j)=t; % 第k个尺子第j个q的配分函数，Xq(ξ),这里用到两个循环，即考虑到了幂函数，又需考虑求和
    end
    j=j+1;
end

%% 谱函数主循环
side_length= rmin:rmax;  % 尺子长度
side_length=side_length';
q=qmin:qd:qmax;    % q分层参数

m=1;
slope=zeros(qno,1);
for i=1:qno
    s=XX(:,i); % 每一层所有尺子的配分函数
    b=polyfit(log(side_length),log(s),1);  % 在对数尺度下计算斜率,一阶拟合
    slope(m,1)=b(1,1);%  这里的Slope即为质量指数，τ(q)
    m=m+1;
end

%plot(q',slope)    % 若τ(q)-q为线性关系，则为单分形；若τ(q)-q是凸函数，
Alpha=diff(slope)./diff(q');   % 奇异指数Alpha
q=q';
f_a=Alpha.*q(2:end)-slope(2:end); %奇异谱函数

%% 画图
% figure
% plot(Alpha,f_a,'o')
% xlabel('α','FontSize',12);
% ylabel('f(α)','FontSize',12);