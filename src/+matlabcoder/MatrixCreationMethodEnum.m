classdef MatrixCreationMethodEnum < uint8

% @see [[https://ww2.mathworks.cn/help/matlab/matlab_oop/operations-on-enumerations.html]]
% @see [[https://ww2.mathworks.cn/help/matlab/matrices-and-arrays.html?s_tid=CRUX_lftnav]] 
%
% 创建和合并数组方式
% zeros	创建全零数组
% ones	创建全部为 1 的数组
% rand	均匀分布的随机数
% true	逻辑值 1（真）
% false	逻辑 0（假）
% eye	单位矩阵
% diag	创建对角矩阵或获取矩阵的对角元素
% blkdiag	分块对角矩阵
% cat	串联数组。
% horzcat	水平串联数组
% vertcat	垂直串联数组
% repelem	重复数组元素副本
% repmat	重复数组副本
  
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

