%% �߽���������ɣ��������أ�
function [len,Code]=sd_chainCode(B,n)
[len,~]=size(B{1}); % ��ȡ�߽�����ص�����B[1]��������
Code=[];

for i=2:len
    % ԭ��λ�����Ͻǣ�x��ָ�£�y��ָ��
    x=B{1}(i,1)-B{1}(i-1,1); % x ��
    y=B{1}(i,2)-B{1}(i-1,2); % y ��
    if n == 8 % ����8����ʱ
        if x==1&&y==0
            Code=[Code,0]; % ��
        elseif x==1&&y==1
            Code=[Code,1]; % �K
        elseif x==0&&y==1
            Code=[Code,2]; % ��
        elseif x==-1&&y==1
            Code=[Code,3]; % �J
        elseif x==-1&&y==0
            Code=[Code,4]; % ��
        elseif x==-1&&y==-1
            Code=[Code,5]; % �I
        elseif x==0&&y==-1
            Code=[Code,6]; % ��
        elseif x==1&&y==-1
            Code=[Code,7]; % �L
        end
    else % ����4����ʱ
        if x==1&&y==0
            Code=[Code,0]; % ��
        elseif x==0&&y==1
            Code=[Code,1]; % ��
        elseif x==-1&&y==0
            Code=[Code,2]; % ��
        elseif x==0&&y==-1
            Code=[Code,3]; % ��
        end
    end % 4����8�������ص�if-else
end % for
    len=len-1; % ����λ��������������1
end
