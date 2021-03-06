classdef MatrixHandleCreationTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testCreateWithMatrix(testCase)
      data = [1 2; 3 4];
      handle = matlabcoder.MatrixHandle(data);
      testCase.assertEqual(handle.data, data);
    end
    
    function testCreateWithEnum(testCase)
      data = zeros(5, 10);
      handle = matlabcoder.MatrixHandle(matlabcoder.MatrixCreationMethodEnum.Zeros, 5, 10);
      testCase.assertEqual(handle.data, data);
    end
    
    function testCreateWithHandle(testCase)
      data = [1 2; 3 4];
      dataHandle = matlabcoder.MatrixHandle(data);
      handle = matlabcoder.MatrixHandle(dataHandle);
      testCase.assertEqual(handle.data, data);
    end
    
    function testCreateWithFunction(testCase)
      data = [1 2; 3 4];
      handle = matlabcoder.MatrixHandle( @(x) data);
      testCase.assertEqual(handle.data, data);
    end
    
  end % methods (Test)
  
end
