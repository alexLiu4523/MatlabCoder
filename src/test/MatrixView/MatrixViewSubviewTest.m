classdef MatrixViewSubviewTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testSubviewWithEmptyIndex(testCase)
      subview = MatrixViewSubviewTest.testMatrixView.subview(matlabcoder.EmptyIndex.INSTANCE, matlabcoder.EmptyIndex.INSTANCE);
      
      testCase.assertEmpty(subview.viewData());
    end
    
    function testSubviewWithOverBoundaryIndexes(testCase)
      subview = MatrixViewSubviewTest.testMatrixView.subview(matlabcoder.AllIndex.INSTANCE, matlabcoder.UnitSpacedIndex(100, 101));
      
      testCase.assertEmpty(subview.viewData());
    end
    
    function testSubviewWithSinglePositionIndex(testCase)
      subview = MatrixViewSubviewTest.testMatrixView.subview(matlabcoder.SinglePositionIndex(2), matlabcoder.SinglePositionIndex(3));
      
      testCase.assertEqual(subview.viewData(), [14]);
    end
    
    function testSubviewWithOverBoundarySinglePositionIndex(testCase)
      subview = MatrixViewSubviewTest.testMatrixView.subview(matlabcoder.SinglePositionIndex(2), matlabcoder.SinglePositionIndex(10));
      
      testCase.assertEmpty(subview.viewData());
    end
    
  end % methods (Test)
  
  properties(Constant)
    testMatrixHandle = matlabcoder.MatrixHandle(@() [1:10; 11:20; 21:30]);
    testMatrixView = MatrixViewSubviewTest.testMatrixHandle.subview(matlabcoder.AllIndex.INSTANCE, matlabcoder.UnitSpacedIndex(2, 9));
    
    % testMatrixView is of form:
    % 2     3     4     5     6     7     8     9
    % 12    13    14    15    16    17    18    19
    % 22    23    24    25    26    27    28    29
  end
  
end
