classdef MatrixHandleAsReferenceTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testDirectAssignOnePosition(testCase)
      handle = matlabcoder.MatrixHandle(@() zeros(5, 5));
      handle.data(3, 3) = 5;
      
      expectData = zeros(5, 5);
      expectData(3, 3) = 5;
      testCase.assertEqual(handle.data, expectData);
    end

    function testDirectAssignWithMatrix(testCase)
      handle = matlabcoder.MatrixHandle(@() zeros(5, 5));
      handle.data(2:3, 3:4) = ones(2, 2);
      
      expectData = zeros(5, 5);
      expectData(2:3, 3:4) = ones(2, 2);
      testCase.assertEqual(handle.data, expectData);
    end
    
  end % methods (Test)
  
end
