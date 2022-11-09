%% Minimum cyclic chain code Representation
% ------------------------------------------------------------
% This program do things as below:
% downsampling
% Boundary Extraction
% Generate 4 chain code, 8 chain code, 
%     differential chain code, and min cyclic chain code representation
% Show Boundary imgs
% -------------------------------------------------------------
% functions��
% sd_ means self defined
%
% main ������
% sd_doAll(B,n) ���ܼ��Ϻ��������룬������룬��Сѭ�����룩
% ������3����sd_doALL�б����ã�
%   [len,Code]=sd_chainCode(B)             ��������
%   [len,SubCode]=sd_subCode(Code)         ����һ�ײ������
%   [len,Code]=sd_minRepresentation(Code)  ������Сѭ������
%
% sd_edgeMap(I,B)     ��������ͼ
% im2=sd_rotation(im,n)                  ��תͼ��90��
% --------------------------------------------------------------
% PS
% 1.The origin is at the upper left corner, x��, y��
% 2.The differential chain code has the same length with the chain code. 
%    The differential chain code is supplemented by the first digit, 
%    that is, the last digit of the differential chain code is obtained by 
%    subtracting the last digit from the first digit of the chain code
% 3.The processed image is a binary image with only one connected region��
% ----------------------------------------------------------------
% References
% [1] https://blog.csdn.net/mr_muli/article/details/81610668
% [2] https://blog.csdn.net/m0_37407756/article/details/69665182
% [3] https://www.cnblogs.com/Penn000/p/7457201.html
% [4] https://blog.csdn.net/friendan/article/details/8824682

%% ������
function main
close all;clear all;clc;
format compact % ���ʱѹ���ո�

I1 = imread('./approximate_triangle.bmp');

I2 = sd_resample(I1); % 20������������ͼ������������,�������ɵ��������

% ��ȡ����[1]
%I=im2bw(I); % ��I��Ϊһ����ֵ��ͼ��
% B = bwboundaries(BW,conn)��������ʽ�� 
%      ���ã���ȡ��ֵͼ�ж����������
%            B��һ��P��1��cell���飬PΪ���������ÿ��cell��Q��2�ľ��󣬶�Ӧ�ڶ����������ص����ꡣ
% B=boundaries(I,8,'cw');
% Ѱ������,BΪ�洢������Ϣ�Ľṹ��
B1_8=bwboundaries(I2); % ��ȡ 8 �ڽ�����(Ĭ��)
B1_4=bwboundaries(I2,4); % ��ȡ 4 �ڽ�����

% ��תǰ
sd_doAll(B1_8,8); % 8�ڽӱ߽�����룬������룬��Сѭ�����룬��С�������
sd_doAll(B1_4,4); % 4�ڽӱ߽�����룬������룬��Сѭ�����룬��С�������

% ��ת��
I3=sd_rotation(I1,-90); % ˳ʱ����ת90��
I4 = sd_resample(I3); % 20������������ͼ������������,�������ɵ��������
B2_8=bwboundaries(I4); % ��ȡ 8 �ڽ�����(Ĭ��)
B2_4=bwboundaries(I4,4); % ��ȡ 4 �ڽ�����
sd_doAll(B2_8,8); % 8�ڽӱ߽�����룬������룬��Сѭ�����룬��С�������
sd_doAll(B2_4,4); % 4�ڽӱ߽�����룬������룬��Сѭ�����룬��С�������


% �����´��ڲ���ʾͼ��
figure('Name','����'); 
subplot(2,4,1);imshow(I1);title('ԭͼ');
subplot(2,4,2);imshow(I2);title('��20���ز���');
subplot(2,4,3);imshow(sd_edgeMap(I2,B1_8));title('8�ڽ�����ͼ');
subplot(2,4,4);imshow(sd_edgeMap(I2,B1_4));title('4�ڽ�����ͼ');
subplot(2,4,5);imshow(I3);title('ԭͼ˳ʱ����ת90��');
subplot(2,4,6);imshow(I4);title('��20���ز���');
subplot(2,4,7);imshow(sd_edgeMap(I4,B2_4));title('8�ڽ�����ͼ');
subplot(2,4,8);imshow(sd_edgeMap(I4,B2_4));title('4�ڽ�����ͼ');

% �������ΪĬ�ϸ�ʽ
format
end % main��������

%% ���ܼ��Ϻ��������룬������룬��Сѭ�����룩
function sd_doAll(B,n) % B ͼ�������� n 4�ڽӣ�8�ڽ�
% ���������
[len,Code] = sd_chainCode(B,n);
fprintf('\n %d�ڽ����룺%d λ��\n', n,len)
Code

% һ�ײ�����������  
[len,SubCode]=sd_subCode(Code,n);
fprintf('\n %d�ڽӲ�����룺%d λ��\n', n,len)
SubCode

% ��Сѭ�����루��һ����
[len,MinReCode]=sd_minRepresentation(Code);
fprintf('\n %d�������Сѭ�����룺%d λ��\n', n,len)
MinReCode
[len,MinReSubCode]=sd_minRepresentation(SubCode);
fprintf('\n %d�������Сѭ��������룺%d λ��\n', n,len)
MinReSubCode
disp('--------------------')
end



%% ��������ͼ
function  im=sd_edgeMap(I,B)
[M,N]=size(I);
im=zeros(M,N); % ����ͼ���ڸ�������
for k=1:length(B)
    boundary=B{k};
    % ��k������������
    %�������������boundary�ĵ�һ���
    %���ӹ��������Կ���boundary��80��Ԫ�أ�ÿ�����������ֵ��x��y���꣩��
    % �洢��������������
    for p=1:length(boundary) % ��ע��k��������������λ��Ϊ1
        im(boundary(p,1),boundary(p,2))=1;
    end
end
end


%% ��תͼ��90�ȣ����л��У�[4]
function im2=sd_rotation(im,n) % nΪ��ת��������ʱ��Ϊ������
%˳ʱ��90�ȣ�ԭ��n�б䵹����n�����򣨻�ԭ��n�б��n�з���
%��ʱ��90�ȣ�ԭ��n�б��n�з��򣨻�ԭ��n�б䵹����n������
%180�ȣ�ԭ��n�б䵹����n�з�������90�ȣ�
[row,col]=size(im); % row�У�col��
if n==-90 % ˳ʱ��90��
    im2=zeros(col,row); % ������ͼƬʱ��ת90�Ȼᵼ�³���Χ��ͬ
    for i=1:row-1
        for j=1:col-1
            im2(j,row-i)=im(i,j); % j����������row-i�����е���
        end
    end
    disp('==========˳ʱ����ת90�Ⱥ�==========')
elseif n==90 % ��ʱ��90��
    im2=zeros(col,row);
    for i=1:row-1
        for j=1:col-1
            im2(col-j,i)=im(i,j); % i����������col-j�����е���
        end
    end
    disp('==========��ʱ����ת90�Ⱥ�==========')
else % 180��
    im2=zeros(row,col);
    for i=1:row-1
        for j=1:col-1
            im2(row-i,col-j)=im(i,j); % i�����е�����j�����з���
        end
    end
    disp('==========��ת180�Ⱥ�==========')
end
end
