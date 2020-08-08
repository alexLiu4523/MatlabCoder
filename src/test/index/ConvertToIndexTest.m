classdef ConvertToIndexTest < matlab.unittest.TestCase
  
  methods (Test)
    
    function testConvertIndexType(testCase)
      input = matlabcoder.UnitSpacedIndex(1, 10);
      res = matlabcoder.IndexBase.convertToIndex(input);
      
      testCase.verifyEqual(res, input);
    end
    
    function testConvertSingleNumber(testCase)
      input = 1;
      res = matlabcoder.IndexBase.convertToIndex(input);
      
      testCase.verifyEqual(res, matlabcoder.SinglePositionIndex(input));
    end
    
    function testConvertNumbers(testCase)
      input = 1 : 5;
      res = matlabcoder.IndexBase.convertToIndex(input);
      
      testCase.verifyEqual(res, matlabcoder.PositionIndex(input));
    end
    
    function testConvertAll(testCase)
      input = ':';
      res = matlabcoder.IndexBase.convertToIndex(input);
      
      testCase.verifyEqual(res, matlabcoder.AllIndex.INSTANCE);
    end
    
    
    function testConvertFunction(testCase)
      input = @(x) x > 10;
      res = matlabcoder.IndexBase.convertToIndex(input);
      
      testCase.verifyEqual(res, matlabcoder.LogicalIndex(input));
    end
    
    function testConvertAllSymbol(testCase)
      input = ':';
      res = matlabcoder.IndexBase.convertToIndex(input);
      
      testCase.verifyEqual(res, matlabcoder.AllIndex.INSTANCE);
    end
    
    function testConvertEmptyVector(testCase)
      input = [];
      res = matlabcoder.IndexBase.convertToIndex(input);
      
      testCase.verifyEqual(res, matlabcoder.EmptyIndex.INSTANCE);
    end
    
  end % methods (Test)
  
end
