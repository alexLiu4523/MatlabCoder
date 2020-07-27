classdef UnitSpacedIndexComposeTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testComposeWithAllIndex(testCase)
      index = matlabcoder.UnitSpacedIndex(10, 20);
      subIndex = matlabcoder.AllIndex.INSTANCE;
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, index);
    end
    
    function testComposeWithEmptyIndex(testCase)
      index = matlabcoder.UnitSpacedIndex(10, 20);
      subIndex = matlabcoder.EmptyIndex.INSTANCE;
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, matlabcoder.EmptyIndex.INSTANCE);
    end
    
    function testComposeWithUnitSpacedIndex1(testCase)
      index = matlabcoder.UnitSpacedIndex(11, 20);
      subIndex = matlabcoder.UnitSpacedIndex(5, 7);
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, matlabcoder.UnitSpacedIndex(15, 17));
    end
    
    function testComposeWithUnitSpacedIndex2(testCase)
      index = matlabcoder.UnitSpacedIndex(11, 20);
      subIndex = matlabcoder.UnitSpacedIndex(5, 10);
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, matlabcoder.UnitSpacedIndex(15, 20));
    end
    
    function testComposeWithUnitSpacedIndex3(testCase)
      index = matlabcoder.UnitSpacedIndex(11, 20);
      subIndex = matlabcoder.UnitSpacedIndex(5, 20);
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, matlabcoder.UnitSpacedIndex(15, 20));
    end
    
    function testComposeWithRegularlySpacedIndex1(testCase)
      index = matlabcoder.UnitSpacedIndex(11, 20);
      subIndex = matlabcoder.RegularlySpacedIndex(5, 7, 2);
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, matlabcoder.RegularlySpacedIndex(15, 17, 2));
    end
    
    function testComposeWithRegularlySpacedIndex2(testCase)
      index = matlabcoder.UnitSpacedIndex(11, 20);
      subIndex = matlabcoder.RegularlySpacedIndex(5, 10, 2);
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, matlabcoder.RegularlySpacedIndex(15, 20, 2));
    end
    
    function testComposeWithRegularlySpacedIndex3(testCase)
      index = matlabcoder.UnitSpacedIndex(11, 20);
      subIndex = matlabcoder.RegularlySpacedIndex(5, 20, 2);
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, matlabcoder.RegularlySpacedIndex(15, 20, 2));
    end
    
    function testComposeWithSinglePositionIndex1(testCase)
      index = matlabcoder.UnitSpacedIndex(11, 20);
      subIndex = matlabcoder.SinglePositionIndex(5);
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, matlabcoder.SinglePositionIndex(15));
    end
    
    function testComposeWithSinglePositionIndex2(testCase)
      index = matlabcoder.UnitSpacedIndex(11, 20);
      subIndex = matlabcoder.SinglePositionIndex(10);
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, matlabcoder.SinglePositionIndex(20));
    end
    
    function testComposeWithSinglePositionIndex3(testCase)
      index = matlabcoder.UnitSpacedIndex(11, 20);
      subIndex = matlabcoder.SinglePositionIndex(11);
      composedIndex = index.compose(subIndex);
      
      testCase.assertEqual(composedIndex, matlabcoder.EmptyIndex.INSTANCE);
    end
    
  end % methods (Test)

end
