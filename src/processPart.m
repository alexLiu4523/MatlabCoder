function processPart(matrixHandle, startIndex, endIndex, inc)
coder.inline('never');

% `matrixHandle(startIndex:endIndex, startIndex:endIndex)` creates a matrix with copy

% import matlabcoder.asMatrixView; % Error, import not support
% index1 = matlabcoder.makeIndex2(startIndex, endIndex);
% index2 = matlabcoder.makeIndex2(startIndex, endIndex);
matrixView = matrixHandle.view(startIndex:endIndex, startIndex:endIndex); % MatrixHandle's subsref returns a MatrixView
matrixView = matrixView + inc; % matrixView = Stub_MatrixSclarAdd(matrixView, inc);

inc = inc + sum(matrixView(:));
% inc = inc + sum(matrixView.matrixHandle.data(:));

% Error, left side can not be a result of function call
% asMatrixView(handler.data(startIndex:endIndex, startIndex:endIndex)) = asMatrixView(handler.data(startIndex:endIndex, startIndex:endIndex)) + inc;

for i = startIndex:endIndex
  for j = startIndex:endIndex
    matrixHandle.data(i, j) = matrixHandle.data(i, j) + inc;
  end
end

end
