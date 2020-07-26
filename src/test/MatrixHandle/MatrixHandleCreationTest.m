classdef MatrixHandleCreationTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testCreateWithMatrix(testCase)
      data = [1 2 3];
      handle = matlabcoder.MatrixHandle(data);
      testCase.assertEqual(handle.data, data);
    end
    
    function testCreateWithEnum(testCase)
      data = zeros(5, 10, 5);
      handle = matlabcoder.MatrixHandle(matlabcoder.MatrixCreationMethodEnum.Zeros, 5, 10, 5);
      testCase.assertEqual(handle.data, data);
    end
    
    function testCreateWithFunctionHandle(testCase)
      data = [1 2 3];
      handle = matlabcoder.MatrixHandle( @(x) data);
      testCase.assertEqual(handle.data, data);
    end
    
  end % methods (Test)
  
end
