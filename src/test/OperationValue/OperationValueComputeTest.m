classdef OperationValueComputeTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testComputeMatrixPlusMatrix(testCase)
      data1 = [2 3 4; 3 5 6];
      handle1 = matlabcoder.MatrixHandle(data1);
      handle1View = handle1.subview(matlabcoder.AllIndex.INSTANCE, matlabcoder.AllIndex.INSTANCE);
      
      data2 = ones(2, 3);
      handle2 = matlabcoder.MatrixHandle(data2);
      handle2View = handle2.subview(matlabcoder.AllIndex.INSTANCE, matlabcoder.AllIndex.INSTANCE);
      
      operationValue = ...
        matlabcoder.OperationValue.of(handle1View, matlabcoder.MatrixOperationEnum.PlusMatrix, handle2View);
      plusRes = operationValue.compute();
      
      testCase.assertEqual(plusRes, data1 + data2)
    end
    
    function testComputeMatrixPlusScalar(testCase)
      data1 = [2 3 4; 3 5 6];
      handle1 = matlabcoder.MatrixHandle(data1);
      handle1View = handle1.subview(matlabcoder.AllIndex.INSTANCE, matlabcoder.AllIndex.INSTANCE);
      
      data2 = 1;
      
      operationValue = ...
        matlabcoder.OperationValue.of(handle1View, matlabcoder.MatrixOperationEnum.PlusScalar, data2);
      plusRes = operationValue.compute();
      
      testCase.assertEqual(plusRes, data1 + data2)
    end
    
  end % methods (Test)
  
end
