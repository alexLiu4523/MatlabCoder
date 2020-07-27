classdef MatrixHandleEqTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testEqForEmpty(testCase)
      data = [];
      handle = matlabcoder.MatrixHandle(data);
      
      testCase.assertTrue(handle == matlabcoder.MatrixHandle(@() []));
      testCase.assertTrue(handle ~= matlabcoder.MatrixHandle(@() [1 2]));
    end
    
    function testEqForOneElementMartix(testCase)
      handle = matlabcoder.MatrixHandle(@() ones(1, 1));
      
      testCase.assertTrue(handle == matlabcoder.MatrixHandle(@() ones(1, 1)));
      testCase.assertTrue(handle ~= matlabcoder.MatrixHandle(@() []));
      testCase.assertTrue(handle ~= matlabcoder.MatrixHandle(@() zeros(1, 1)));
    end
    
    function testEqForMartix(testCase)
      data = [1 2; 3 4];
      handle = matlabcoder.MatrixHandle(data);
      
      testCase.assertTrue(handle == matlabcoder.MatrixHandle(@() [1 2;
        3 4]));
      testCase.assertTrue(handle ~= matlabcoder.MatrixHandle(@() []));
      testCase.assertTrue(handle ~= matlabcoder.MatrixHandle(@() zeros(1, 1)));
    end
    
  end % methods (Test)
  
end
