clear
close all
%% 参数准备
rinterval=[2,10];
qinterval=[-160,1,160];
load('TData1.mat')
Date1={'2010/9/21','2010/9/27','2010/10/14','2010/10/22',...
    '2010/10/29','2010/11/5','2010/11/11','2010/11/19'}';
Date2={'2007/7/19','2007/7/20','2007/9/11','2007/9/20',...
    '2007/10/16','2007/10/17','2007/10/18','2007/10/31'...
    ,'2007/11/1','2007/8/17','2007/8/17','2007/9/26','2007/9/27'...
    ,'2008/1/14','2008/1/15','2008/2/1','2008/2/4'}';
Date3={'2012/12/4','2012/12/5','2013/1/11','2013/1/14',...
    '2013/2/8','2013/5/29','2013/5/31','2013/2/28','2013/3/1'...
    ,'2013/1/25','2013/1/28','2013/5/23','2013/5/24'}';
freq=5;%freq为数据频率,以分钟为单位
NoDays=7;%选用数据天数
%% 函数调用
for i=1:3
    eval(['Date','=Date',num2str(i)])
    for pl=1:2
        figure
        [f_a,Alpha]=MultifractalRE(rinterval,qinterval,TData,Date,freq,NoDays,pl);
    end
end