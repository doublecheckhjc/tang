function [f_a,Alpha]=MultifractalRE(rinterval,qinterval,TData,Date,freq,NoDays,pl)
%[f_a,Alpha]=MultifractalRE(rinterval,qinterval,TData,Date,freq,NoDays,pl)
%rintervalΪ����ȡֵ��Χrinterval=[rmin,rmax];
%rminΪ���ڵ���2�������������Ϊ���ݳ���
%qintervalΪqȡֵ��Χqinterval=[qmin,q����,qmax];
%TDataΪ�����ݵ�һ�����ڣ��ڶ�������
%DateΪ����������
%freqΪ����Ƶ��,�Է���Ϊ��λ
%NoDaysѡ����������
%% ��������
Data1=MulDataGenerator(TData,Date,freq,NoDays);
lDate=length(Date);
%% ���μ���
rinterval(2)=fix(239/freq+1)*NoDays;
for i=1:lDate
    Data(:,1)=Data1(:,i);
    [f_a,Alpha]=AlphaR(Data,rinterval,qinterval);
%     f_set(:,1)=
    if pl==1
        subplot(2,lDate/2,i);
        plot(Alpha,f_a,'o')
        xlabel('��','FontSize',12);
        ylabel('f(��)','FontSize',12);
        eval(['title(''���ڣ�',Date{i},' '');']);
        legend(Date{i});
    end
    if pl==2
        color='rgbkycmrgbkycmrgbkycmrgbkycmrgbkycmrgbkycmrgbkycm';
        plot(Alpha,f_a,[color(i),'o'])
        xlabel('��','FontSize',12);
        ylabel('f(��)','FontSize',12);
        eval(['title(''���ڣ�',Date{i},' '');']);
        legend(Date);
        hold on
    end
end









