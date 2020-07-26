classdef MatrixCreationMethodEnum < uint8

% @see [[https://ww2.mathworks.cn/help/matlab/matlab_oop/operations-on-enumerations.html]]
% @see [[https://ww2.mathworks.cn/help/matlab/matrices-and-arrays.html?s_tid=CRUX_lftnav]] 
%
% �����ͺϲ����鷽ʽ
% zeros	����ȫ������
% ones	����ȫ��Ϊ 1 ������
% rand	���ȷֲ��������
% true	�߼�ֵ 1���棩
% false	�߼� 0���٣�
% eye	��λ����
% diag	�����ԽǾ�����ȡ����ĶԽ�Ԫ��
% blkdiag	�ֿ�ԽǾ���
% cat	�������顣
% horzcat	ˮƽ��������
% vertcat	��ֱ��������
% repelem	�ظ�����Ԫ�ظ���
% repmat	�ظ����鸱��
  
  enumeration
      Zeros(0), 
      Ones(1), 
      Rand(2), 
      True(3), 
      False(4),
      Eye(5),
      Diag(6)
  end
  
end

