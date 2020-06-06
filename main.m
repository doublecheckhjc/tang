clc
clear
close all
load train_fin.mat
[M,N]=size(train_train);
for i=1:1:M
    temp=boxcount(train_train(1,:));
    y(i)=temp(2);
end

