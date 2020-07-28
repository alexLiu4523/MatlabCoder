function res = OperationValueTest()

matrixHandle = matlabcoder.MatrixHandle(ones(10, 10));
view = matrixHandle.subview(matlabcoder.UnitSpacedIndex(1, 2), matlabcoder.SinglePositionIndex(2));

% op1 = matlabcoder.OperationValueForMatrixMatrix(view, matlabcoder.MatrixOperationEnum.PlusMatrix, view);
op1 = matlabcoder.OperationValue.of(view, matlabcoder.MatrixOperationEnum.PlusMatrix, view);
op1ResMatrix = op1.compute();
res = sum(op1ResMatrix(:));

% op2 = matlabcoder.OperationValueForMatrixScalar(view, matlabcoder.MatrixOperationEnum.PlusScalar, 1);
op2 = matlabcoder.OperationValue.of(view, matlabcoder.MatrixOperationEnum.PlusScalar, 1);
op2ResMatrix = op2.compute();
res = res + sum(op2ResMatrix(:));

end
