function [fstdate,lstdate]=MulGetdate(TData,Date,Dayno)
%[fstdate,lstdate]=MulGetdate(TData,Date,freq)
%TDataΪ������
%DateΪ����������
%Dayno��ǰƵ���������ݸ���
%fstsig���ھ����е�������Data�е�һ�γ��ֵ�����
%lstsig���ھ����е�������Data�����һ�γ��ֵ�����
%% Ԥ��ȡ ����������ӷֿ� ��1:3��Ϊ���ڡ����ݡ�����
lTData=length(TData);
TData1=cell(lTData,3);
for i=1:lTData
    m=find(TData{i}==' ');
    TData1{i,1}=TData{i,1}(1:m-1);
    TData1{i,2}=TData{i,2};
    TData1{i,3}=TData{i,1}(m+1:end);
end

%% ���ݶ���
% [~,col]=cellfun(@size,Date);%dateԪ������ÿ�������ֽڳ���
ldate=length(Date);%���ھ��󳤶ȣ����ж����죩
lTData=length(TData1);%���ݾ��󳤶ȣ����ж������ݣ�
sig=zeros(lTData,1);%�źž���Data�еڼ�����Date�еļ���
fstdate=zeros(ldate,1);%���ھ����е�������Data�е�һ�γ��ֵ�����
mark=zeros(ldate,1);%�����Ƿ��Ѿ�����

%% ��ѭ��
p=1;%fstsig������
for i=1:lTData
    for j=1:ldate
        %if strcnmpi(Date(j),TData1{i,1},col(j))%ǰn���ַ��Ƿ����
        if mark(j)~=0
            continue
        end
        if strcmpi(Date{j},TData1{i,1}) %��ȫ���
            sig(i,1)=j;
            if mark(j)==0
                fstdate(j)=i;
                mark(j)=1;
            end
        end
        smark=sum(mark);
        if smark==ldate
            break
        end
    end
end
lstdate=fstdate+Dayno-1;

