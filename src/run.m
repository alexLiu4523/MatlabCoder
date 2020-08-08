
%handle:MatrixHandle
% data = zeros(5, 5);
% data(1:3, 1:3) = ones(3, 3);

handle1 = matlabcoder.MatrixHandle(matlabcoder.MatrixCreationMethodEnum.Zeros, 5, 5);
view1 = handle1.subview(matlabcoder.UnitSpacedIndex(1, 3), matlabcoder.UnitSpacedIndex(1, 3));
view1.assign(ones(3, 3));
% now handle1 is 
% [1,1,1,0,0;
%  1,1,1,0,0;
%  1,1,1,0,0;
%  0,0,0,0,0;
%  0,0,0,0,0]
% and view1 is ones of 3*3

view2 = handle1.subview(matlabcoder.UnitSpacedIndex(2, 4), matlabcoder.UnitSpacedIndex(2, 4));
% view 2 is
% [1,1,0;
%  1,1,0;
%  0,0,0];

handle2 = matlabcoder.MatrixHandle(@() zeros(5, 5));
view3 = handle2.subview(matlabcoder.UnitSpacedIndex(2, 4), matlabcoder.UnitSpacedIndex(2, 4));
view3.assign(view1 + view2);
% now handle2 is 
% [0,0,0,0,0;
%  0,2,2,1,0;
%  0,2,2,1,0;
%  0,1,1,1,0;
%  0,0,0,0,0]

view4 = handle1.subview(matlabcoder.UnitSpacedIndex(3, 5), matlabcoder.UnitSpacedIndex(3, 5));
view4.assign(view4 + view1);
% after `handle1(2:4, 2:4) = handle1(2:4, 2:4) + handle1(1:3, 1:3)`, handle1 is
% [1,1,1,0,0;
%  1,1,1,0,0;
%  1,1,2,1,1;
%  0,0,1,1,1;
%  0,0,1,1,1]

% m = zeros(5, 5);
% a = m(1:end, 5);
% b = m(1:0);

% view0 = handle.view(@(f) f > 6);
% view1 = handle(1:3, :);
% view2 = handle(1:end, 1); % TODO: the s.subs is [[1], [1]] 
% view3 = handle.view(1, 3); 
% view4 = handle.view(1:end, 3); % TODO: view method receive no argument 

% view5 = handle.view(matlabcoder.AllIndex.INSTANCE, matlabcoder.AllIndex.INSTANCE); % matlabcoder.AllIndex.getInstance()
% view6 = handle.view(matlabcoder.AllIndex.INSTANCE, matlabcoder.AllIndex.INSTANCE);
% res1 = view5 == view6;
% 
% index1 = matlabcoder.UnitSpacedIndex(1, 2);
% index2 = matlabcoder.RegularlySpacedIndex(1, 5, 1);
% 
% view7 = handle.view(index1, index1);
% res = view7.viewData();

% Test for builtin
% y = min(handle);
%
% function res = min(x)
%   if isa(x, 'matlabcoder.MatrixHandle')
%     res = -1;
%   else
%     res = builtin('min', x);
%   end
% end

% Test for varargin
% res = rec1(1, 2);
% 
% function res = rec1(varargin)
%   res = rec2(varargin{:});
% end
% 
% function res = rec2(varargin)
%   res = zeros(varargin{:}); 
% end

% Test for pass function
% handle = matlabcoder.MatrixHandle(@() zeros(5, 5));

% Test for subsasgn
% handle(1, 1) = view;
% Note: 如果重载了 subref 但未重载 subsasgn，由于左操作数为 MatrixHandle 矩阵，则 MATLAB 首先尝试将 view 转换为 MatrixHandle （以 view 为输入调用 MatrixHandle 的构造函数），
% handle(3, 1) 则被视为内置矩阵索引操作（将 handle 自动扩充为 3*1 矩阵），然后进行赋值
% 换言之，handle(3, 1) 在左操作数时，不会调用 subref
% 因此，必需重载 subsasgn

% view(1,2) = view;

