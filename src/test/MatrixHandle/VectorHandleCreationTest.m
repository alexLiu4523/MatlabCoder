classdef VectorHandleCreationTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testCreateWithVector(testCase)
      data = [1 2 3];
      handle = matlabcoder.VectorHandle(data);
      testCase.assertEqual(handle.data, data);
    end
    
    function testCreateWithEnum(testCase)
      data = zeros(5, 1);
      handle = matlabcoder.VectorHandle(matlabcoder.MatrixCreationMethodEnum.Zeros, 5, 1);
      testCase.assertEqual(handle.data, data);
    end
    
    function testCreateWithHandle(testCase)
      data = [1 2 3];
      dataHandle = matlabcoder.MatrixHandle(data);
      handle = matlabcoder.MatrixHandle(dataHandle);
      testCase.assertEqual(handle.data, data);
    end
    
    function testCreateWithFunction(testCase)
      data = [1 2 3];
      handle = matlabcoder.VectorHandle( @(x) data);
      testCase.assertEqual(handle.data, data);
    end
    
  end % methods (Test)
  
end
