function Data=MulDataGenerator(TData,Date,freq,NoDays)
%Data=MulDataGenerator(TData,Date,freq,NoDays)
%TDataΪ�����ݵ�һ�����ڣ��ڶ�������
%DateΪ����������
%freqΪ����Ƶ��,�Է���Ϊ��λ
%NoDaysѡ����������
%% ׼������
Dayno=fix(239/freq+1);%��ǰƵ���������ݸ���
Addno=(NoDays-1)*Dayno;%�ﵽ�ͺ�����Ҫ���貹��ĸ�Ƶ��������
[fstdate,lstdate]=MulGetdate(TData,Date,Dayno);%��ȡ���ڳ���λ��
Dateinterval(:,1)=fstdate-Addno;%�������
Dateinterval(:,2)=lstdate;%�����յ�
%% �������ݼ�
lDate=length(Date);
linterval=Dateinterval(:,2)-Dateinterval(:,1)+1;
Data1=cell(linterval(1),lDate);
for i=1:lDate
    Data1(:,i)=TData(Dateinterval(i,1):Dateinterval(i,2),2);
end
Data=cell2mat(Data1);