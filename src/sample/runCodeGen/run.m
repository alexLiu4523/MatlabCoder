function run(index)

% index is int 1

handle1 = matlabcoder.MatrixHandle(matlabcoder.MatrixCreationMethodEnum.Zeros, 5, 5);
view1 = handle1.subview(matlabcoder.UnitSpacedIndex(index, index+2), matlabcoder.UnitSpacedIndex(index, index+2));
view1.assign(ones(3, 3));
% now handle1 is
% [1,1,1,0,0;
%  1,1,1,0,0;
%  1,1,1,0,0;
%  0,0,0,0,0;
%  0,0,0,0,0]
% and view1 is ones of 3*3

view2 = handle1.subview(matlabcoder.UnitSpacedIndex(index+1, index+3), matlabcoder.UnitSpacedIndex(index+1, index+3));
% view 2 is
% [1,1,0;
%  1,1,0;
%  0,0,0];

handle2 = matlabcoder.MatrixHandle(@() zeros(5, 5));
view3 = handle2.subview(matlabcoder.UnitSpacedIndex(index+1, index+3), matlabcoder.UnitSpacedIndex(index+1, index+3));
view3.assign(view1 + view2);
% now handle2 is
% [0,0,0,0,0;
%  0,2,2,1,0;
%  0,2,2,1,0;
%  0,1,1,1,0;
%  0,0,0,0,0]

view4 = handle1.subview(matlabcoder.UnitSpacedIndex(index+2, index+4), matlabcoder.UnitSpacedIndex(index+2, index+4));
view4.assign(view4 + view1);
% after `handle1(2:4, 2:4) = handle1(2:4, 2:4) + handle1(1:3, 1:3)`, handle1 is
% [1,1,1,0,0;
%  1,1,1,0,0;
%  1,1,2,1,1;
%  0,0,1,1,1;
%  0,0,1,1,1]

end
