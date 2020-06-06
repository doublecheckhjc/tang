function [fstdate,lstdate]=MulGetdate(TData,Date,Dayno)
%[fstdate,lstdate]=MulGetdate(TData,Date,freq)
%TData为总数据
%Date为欲查找日期
%Dayno当前频率下日数据个数
%fstsig日期矩阵中的日期在Data中第一次出现的行数
%lstsig日期矩阵中的日期在Data中最后一次出现的行数
%% 预读取 将日期与分钟分开 第1:3列为日期、数据、分钟
lTData=length(TData);
TData1=cell(lTData,3);
for i=1:lTData
    m=find(TData{i}==' ');
    TData1{i,1}=TData{i,1}(1:m-1);
    TData1{i,2}=TData{i,2};
    TData1{i,3}=TData{i,1}(m+1:end);
end

%% 数据定义
% [~,col]=cellfun(@size,Date);%date元胞数组每个日期字节长度
ldate=length(Date);%日期矩阵长度（共有多少天）
lTData=length(TData1);%数据矩阵长度（共有多少数据）
sig=zeros(lTData,1);%信号矩阵，Data中第几行是Date中的几天
fstdate=zeros(ldate,1);%日期矩阵中的日期在Data中第一次出现的行数
mark=zeros(ldate,1);%日期是否已经出现

%% 主循环
p=1;%fstsig计数器
for i=1:lTData
    for j=1:ldate
        %if strcnmpi(Date(j),TData1{i,1},col(j))%前n个字符是否相等
        if mark(j)~=0
            continue
        end
        if strcmpi(Date{j},TData1{i,1}) %完全相等
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

