function Data=MulDataGenerator(TData,Date,freq,NoDays)
%Data=MulDataGenerator(TData,Date,freq,NoDays)
%TData为总数据第一列日期，第二列数据
%Date为欲查找日期
%freq为数据频率,以分钟为单位
%NoDays选用数据天数
%% 准备数据
Dayno=fix(239/freq+1);%当前频率下日数据个数
Addno=(NoDays-1)*Dayno;%达到滞后天数要求需补充的高频数据数量
[fstdate,lstdate]=MulGetdate(TData,Date,Dayno);%获取日期出现位置
Dateinterval(:,1)=fstdate-Addno;%数据起点
Dateinterval(:,2)=lstdate;%数据终点
%% 生成数据集
lDate=length(Date);
linterval=Dateinterval(:,2)-Dateinterval(:,1)+1;
Data1=cell(linterval(1),lDate);
for i=1:lDate
    Data1(:,i)=TData(Dateinterval(i,1):Dateinterval(i,2),2);
end
Data=cell2mat(Data1);