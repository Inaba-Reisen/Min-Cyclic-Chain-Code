%% 20������������ͼ������������[2]
% �������ɵ��������
function imgOutput = sd_resample(imgInput)
[line,row]=size(imgInput);%��ȡͼ������
L=1; R=1;

for i=1:20:line; % ����Ϊ20
    for j=1:20:row; % �ڵ�i�ж�ԭͼ��û20�в���һ��
        imgOutput(L,R)=imgInput(i,j);
        R=R+1;%ȡԭͼ��i����һ�е�Ԫ�ظ�����ͼ��Ķ�Ӧλ��
    end
    L=L+1;%����
    R=1;%�ӻ��к������ĵ�һ��Ԫ�ؿ�ʼȡԪ��
end
end

