%% һ�ײ����������ɣ��������أ�
function [len,SubCode]=sd_subCode(Code,n)
Code=[Code,Code(1)]; % �������ɲ������ʱ�󲹵�һԪ�ص�����
[~,len]=size(Code); % ��ȡӦ�����λ��
% ���ɲ������
SubCode=[];
for i=2:len
    SubCode=[SubCode,mod((Code(i)-Code(i-1)+n),n)]; % �� mod n ������������[3]
end
len=len-1; % �������λ��������ѭ���Ĵ�����������λ����ͬ
end
