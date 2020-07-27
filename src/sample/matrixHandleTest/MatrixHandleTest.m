function res = MatrixHandleTest()  

matrixHandle = matlabcoder.MatrixHandle(zeros(10, 10));
view = matrixHandle.subview(matlabcoder.UnitSpacedIndex(1, 2), matlabcoder.SinglePositionIndex(2));
view2 = matrixHandle.subview(matlabcoder.UnitSpacedIndex(3, 4), matlabcoder.SinglePositionIndex(2));
view2.assign(view);
% view.subsasgnImpl([1, 1], 5);

matrixHandle = matlabcoder.MatrixHandle(matlabcoder.MatrixCreationMethodEnum.Ones, 5, 5);
sum1 = sum(matrixHandle.data(:));

view5 = matrixHandle.subview(matlabcoder.AllIndex(), matlabcoder.AllIndex());
view6 = matrixHandle.subview(matlabcoder.AllIndex(), matlabcoder.AllIndex());
res1 = view5 == view6;

matrixHandle = matlabcoder.MatrixHandle(zeros(100, 100));
for i = 1 : 10
%  processPart(handler.data((i-1)*10+1 : (i)*10, (i-1)*10+1 : (i)*10), i);
%  processPart(handler((i-1)*10+1 : (i)*10, (i-1)*10+1 : (i)*10)... %view
%              , i)
  processPart(matrixHandle, (i-1)*10+1, (i)*10, 5);
end

% Error : Handle Classes in top-level outputs are not supported in MATLAB Coder. Output parameter 'res' contains a handle class.
% res = handler;
res = sum(matrixHandle.data(:));
res = res + sum1 + res1;

a = plusFun(2);
res = res + a;

b = plusFun(ones(20, 2));
res = res + sum(b(:));

end

function res = plusFun(a)
  coder.inline('never');
  res = a + 1;
end


