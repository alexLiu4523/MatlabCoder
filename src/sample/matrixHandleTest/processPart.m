function processPart(matrixHandle, startIndex, endIndex, inc)
coder.inline('never');

% `matrixHandle(startIndex:endIndex, startIndex:endIndex)` creates a matrix with copy

% import matlabcoder.asMatrixView; % Error, import not support
% index1 = matlabcoder.makeIndex2(startIndex, endIndex);
% index2 = matlabcoder.makeIndex2(startIndex, endIndex);
matrixView = matrixHandle.subview(matlabcoder.UnitSpacedIndex(startIndex, endIndex), matlabcoder.UnitSpacedIndex(startIndex, endIndex)); % MatrixHandle's subsref returns a MatrixView

% Note: `matrixView + inc` works in MATLAB (operation is 'PlusScalar') but not in coder (operation is 'PlusMatrix')
opValue = matlabcoder.OperationValue(matrixView, matlabcoder.MatrixOperationEnum.PlusScalar, inc);
% matrixView + inc; % matrixView = Stub_MatrixSclarAdd(matrixView, inc);

opValueRes = opValue.compute();
inc = inc + sum(opValueRes(:));
% inc = inc + sum(matrixView.matrixHandle.data(:));

% Error, left side can not be a result of function call
% asMatrixView(handler.data(startIndex:endIndex, startIndex:endIndex)) = asMatrixView(handler.data(startIndex:endIndex, startIndex:endIndex)) + inc;

for i = startIndex:endIndex
  for j = startIndex:endIndex
    matrixHandle.data(i, j) = matrixHandle.data(i, j) + inc;
  end
end

end
