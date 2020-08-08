classdef MatrixViewPlusTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testMatrixAddScalar(testCase)
      handle1 = matlabcoder.MatrixHandle(@() zeros(5, 5));
      view1 = handle1.subview(matlabcoder.UnitSpacedIndex(1, 3), matlabcoder.UnitSpacedIndex(1, 3));
      view1.assign(ones(3, 3));
      
      view2 = handle1.subview(matlabcoder.UnitSpacedIndex(2, 4), matlabcoder.UnitSpacedIndex(2, 4));
      view2.assign(view2 + 5);
    
      testCase.assertEqual(handle1.data,  ...
       [1,1,1,0,0;
        1,6,6,5,0;
        1,6,6,5,0;
        0,5,5,5,0;
        0,0,0,0,0]);
    end
    
    function testMatrixAddMatrix(testCase)
      handle1 = matlabcoder.MatrixHandle(@() zeros(5, 5));
      view1 = handle1.subview(matlabcoder.UnitSpacedIndex(1, 3), matlabcoder.UnitSpacedIndex(1, 3));
      view1.assign(ones(3, 3));
      view2 = handle1.subview(matlabcoder.UnitSpacedIndex(2, 4), matlabcoder.UnitSpacedIndex(2, 4));
      
      handle2 = matlabcoder.MatrixHandle(@() zeros(5, 5));
      view3 = handle2.subview(matlabcoder.UnitSpacedIndex(2, 4), matlabcoder.UnitSpacedIndex(2, 4));
      view3.assign(view1 + view2);
    
      testCase.assertEqual(handle2.data,  ...
       [0,0,0,0,0;
        0,2,2,1,0;
        0,2,2,1,0;
        0,1,1,1,0;
        0,0,0,0,0]);
    end
    
%     function testMAddSelf(testCase)
%       handle1 = matlabcoder.MatrixHandle(@() zeros(5, 5));
%       view1 = handle1.subview(matlabcoder.UnitSpacedIndex(1, 3), matlabcoder.UnitSpacedIndex(1, 3));
%       view1.assign(ones(3, 3));
% 
%       view2 = handle1.subview(matlabcoder.UnitSpacedIndex(3, 5), matlabcoder.UnitSpacedIndex(3, 5));
%       view2.assign(view2 + view1);
%     
%       testCase.assertEqual(handle1.data,  ...
%        [1,1,1,0,0;
%         1,1,1,0,0;
%         1,1,2,1,1;
%         0,0,1,1,1;
%         0,0,1,1,1]);
%     end
    
  end % methods (Test)
  
end
