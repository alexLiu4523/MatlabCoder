classdef MatrixViewAssignTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testAssignOfBuiltinNumericMatrix(testCase)
      handle1 = matlabcoder.MatrixHandle(@() zeros(5, 5));
      view1 = handle1.subview(matlabcoder.UnitSpacedIndex(1, 3), matlabcoder.UnitSpacedIndex(1, 3));
      view1.assign(ones(3, 3));
    
      testCase.assertEqual(handle1.data,  ...
       [1,1,1,0,0;
        1,1,1,0,0;
        1,1,1,0,0;
        0,0,0,0,0;
        0,0,0,0,0]);
    end
    
    function testAssignOfMatrixHandle(testCase)
      handle1 = matlabcoder.MatrixHandle(@() zeros(5, 5));
      view1 = handle1.subview(matlabcoder.UnitSpacedIndex(1, 3), matlabcoder.UnitSpacedIndex(1, 3));
      handle2 = matlabcoder.MatrixHandle(@() ones(3, 3));
      view1.assign(handle2);
    
      testCase.assertEqual(handle1.data,  ...
       [1,1,1,0,0;
        1,1,1,0,0;
        1,1,1,0,0;
        0,0,0,0,0;
        0,0,0,0,0]);
    end
    
    function testAssignOfMatrixView(testCase)
      handle1 = matlabcoder.MatrixHandle(@() zeros(5, 5));
      view1 = handle1.subview(matlabcoder.UnitSpacedIndex(1, 3), matlabcoder.UnitSpacedIndex(1, 3));
      handle2 = matlabcoder.MatrixHandle(@() ones(3, 3));
      view2 = handle2.subview(matlabcoder.UnitSpacedIndex(1, 3), matlabcoder.UnitSpacedIndex(1, 3));
      view1.assign(view2);
    
      testCase.assertEqual(handle1.data,  ...
       [1,1,1,0,0;
        1,1,1,0,0;
        1,1,1,0,0;
        0,0,0,0,0;
        0,0,0,0,0]);
    end
    
  end % methods (Test)
  
end
