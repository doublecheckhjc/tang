function [f_a,Alpha]=MultifractalRE(rinterval,qinterval,TData,Date,freq,NoDays,pl)
%[f_a,Alpha]=MultifractalRE(rinterval,qinterval,TData,Date,freq,NoDays,pl)
%rinterval为尺子取值范围rinterval=[rmin,rmax];
%rmin为大于等于2的正整数，最大为数据长度
%qinterval为q取值范围qinterval=[qmin,q步长,qmax];
%TData为总数据第一列日期，第二列数据
%Date为欲查找日期
%freq为数据频率,以分钟为单位
%NoDays选用数据天数
%% 生成数据
Data1=MulDataGenerator(TData,Date,freq,NoDays);
lDate=length(Date);
%% 分形计算
rinterval(2)=fix(239/freq+1)*NoDays;
for i=1:lDate
    Data(:,1)=Data1(:,i);
    [f_a,Alpha]=AlphaR(Data,rinterval,qinterval);
%     f_set(:,1)=
    if pl==1
        subplot(2,lDate/2,i);
        plot(Alpha,f_a,'o')
        xlabel('α','FontSize',12);
        ylabel('f(α)','FontSize',12);
        eval(['title(''日期：',Date{i},' '');']);
        legend(Date{i});
    end
    if pl==2
        color='rgbkycmrgbkycmrgbkycmrgbkycmrgbkycmrgbkycmrgbkycm';
        plot(Alpha,f_a,[color(i),'o'])
        xlabel('α','FontSize',12);
        ylabel('f(α)','FontSize',12);
        eval(['title(''日期：',Date{i},' '');']);
        legend(Date);
        hold on
    end
end









