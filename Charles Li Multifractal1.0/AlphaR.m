function [f_a,Alpha]=AlphaR(Data,rinterval,qinterval)
%[f_a,a]=AlphaR(Data,rinterval,qinterval)
%AlphaRΪ������ط����׵ĺ���
%DataΪ��������������������һ��Ϊ����
%rintervalΪ����ȡֵ��Χrinterval=[rmin,rmax];
%rminΪ���ڵ���2�������������Ϊ���ݳ���
%qintervalΪqȡֵ��Χqinterval=[qmin,q����,qmax];
%% ����׼��
L=length(Data); % �����ݸ���

%���Ӳ���
rmin=rinterval(1);          % ��������
rmax=rinterval(2);
rno=rmax-rmin+1;            % ���Ӹ���
%q����
qmin=qinterval(1);          % q�ķ�Χ
qd=qinterval(2);            % ����
qmax=qinterval(3);
qno=fix((qmax-qmin)/qd+1);  % q�ĸ���

c=zeros(rno,1);
i=1;
for r=rmin:rmax     % ÿ�����䳤��
    c(i,1)=mod(L,r);
    i=i+1;
end
c=c';                 % ���㲻�ܱ��߳�r����������
count=L-c;

format long
modify=1;
modifying=zeros(rno,1);
r=rmin;               % ���ӳ�ʼ����
%% ������ֺ�����ѭ��
%����ÿ��������ֵ
for i=1:rno
    B=Data(1:count(i),1);   % ȡ��ÿ�����Ӷ�Ӧ����������
    ino=length(B)/r;  % ���Ӷ�Ӧ��������interval no
    Tssum=sum(B);
    U=reshape(B,r,ino); % ÿ�б���ÿ����ȫ������
    T=sum(U)./Tssum;  % ÿ�����������
    T=T';
    TT(1:length(T),i)=T;  % ���б��治ͬ�����Tֵ%%%%%%%%%%%%preallocate
    modifying(modify,1)=ino; % ÿ�����Ӷ�Ӧ������(Tֵ�ĸ�����
    r=r+1;
    if r>= rmin+rno   % �Զ��������-3��
        break;        % �߳���ʼ���ƣ�ѭ����ֹ
    end
    modify=modify+1;
end

TT=nonzeros(TT);
to_modifying=zeros(rno,1);
for cugb=1:rno
    to_modifying(cugb,1)=sum(modifying(1:cugb)); % ��i�������ۼ���Tֵ����������
end

j=1;
% q Ϊ������������ȡ1��n��Ϊn���� kȡֵ����һ�£�q���󣬼�����޷�
%ʶ��Ĭ��Ϊ�����q��С������ӽ�0�������岻��ȷ
XX=zeros(rno,qno);
for q=qmin:qd:qmax
    for k=1:rno
        if k==1
            X=TT(1:to_modifying(k,1),1).^q;
        else
            X=TT(to_modifying(k-1,1)+1:to_modifying(k,1),1).^q;
        end
        t=sum(X);
        XX(k,j)=t; % ��k�����ӵ�j��q����ֺ�����Xq(��),�����õ�����ѭ���������ǵ����ݺ��������迼�����
    end
    j=j+1;
end

%% �׺�����ѭ��
side_length= rmin:rmax;  % ���ӳ���
side_length=side_length';
q=qmin:qd:qmax;    % q�ֲ����

m=1;
slope=zeros(qno,1);
for i=1:qno
    s=XX(:,i); % ÿһ�����г��ӵ���ֺ���
    b=polyfit(log(side_length),log(s),1);  % �ڶ����߶��¼���б��,һ�����
    slope(m,1)=b(1,1);%  �����Slope��Ϊ����ָ������(q)
    m=m+1;
end

%plot(q',slope)    % ����(q)-qΪ���Թ�ϵ����Ϊ�����Σ�����(q)-q��͹������
Alpha=diff(slope)./diff(q');   % ����ָ��Alpha
q=q';
f_a=Alpha.*q(2:end)-slope(2:end); %�����׺���

%% ��ͼ
% figure
% plot(Alpha,f_a,'o')
% xlabel('��','FontSize',12);
% ylabel('f(��)','FontSize',12);