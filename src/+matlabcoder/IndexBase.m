classdef IndexBase
  % INDEXBASE
  % @see [[https://www.mathworks.com/help/matlab/math/array-indexing.html]]
  % Sub classes:
  %   UnitSpacedIndex:      x = A(1:10)
  %   RegularlySpacedIndex: x = A(1:5:10)
  %   AllIndex:             x = A(:)
  %   SinglePositionIndex:  x = A(1)
  %   PositionIndex:        x = A([1 3], [2 4])
  %   LogicalIndex:         x = A > 5
  %   EmptyIndex:           all indexes leads to no elements like A(1:0)
  
  properties
    % Note: -1 means index is not specified
    startIndex = -1
    endIndex = -1
  end
  
  methods
    
    function this = IndexBase(startIndex, endIndex)
      this.startIndex = startIndex;
      this.endIndex = endIndex;
    end
    
    function res = eq(this, other)
      res = this.eqImpl(other);
    end

    function res = eqImpl(this, other)
      res = matlabcoder.ViewBase.throwForUnsupportOperation();
    end
    
    function res = isVectorable(this)
      res = matlabcoder.IndexBase.isVectorableIndex(this);
    end
    
    function res = isComposeable(this)
      res = matlabcoder.IndexBase.isComposeableIndex(this);
    end
    
  end
  
  methods(Abstract)
    
    toVector(this);
    
    toMatlabIndex(this);
    
    length(this);
    
    compose(otherIndex);
    
  end
  
  methods(Static)
    
    function res = isIndex(obj)
      res = isa(obj, 'matlabcoder.IndexBase');
    end
    
    function res = isUnitSpacedIndex(index)
      res = isa(index, 'matlabcoder.UnitSpacedIndex');
    end
    
    function res = isRegularlySpacedIndex(index)
      res = isa(index, 'matlabcoder.RegularlySpacedIndex');
    end
    
    function res = isAllIndex(index)
      res = isa(index, 'matlabcoder.AllIndex');
      % TODO: If we can make sure that there is only one instance(`matlabcoder.AllIndex.INSTANCE`) of type `matlabcoder.AllIndex`
      %       then we can just do reference equal to see whether `index` is type `matlabcoder.AllIndex`.
    end
    
    function res = isSinglePositionIndex(index)
      res = isa(index, 'matlabcoder.SinglePositionIndex');
    end
    
    function res = isPositionIndex(index)
      res = isa(index, 'matlabcoder.PositionIndex');
    end
    
    function res = isLogicalIndex(index)
      res = isa(index, 'matlabcoder.LogicalIndexIndex');
    end
    
    function res = isEmptyIndex(index)
      res = isa(index, 'matlabcoder.EmptyIndex');
    end
    
    function res = isVectorableIndex(index)
      % Note: If `isVectorableIndex(index)` returns ture, than `index.toVector()` should works.
      res = matlabcoder.IndexBase.isUnitSpacedIndex(index) || matlabcoder.IndexBase.isRegularlySpacedIndex(index) ...
        || matlabcoder.IndexBase.isSinglePositionIndex(index) || matlabcoder.IndexBase.isPositionIndex(index);
    end
    
    function res = isComposeableIndex(index)
      % Note: If `isComposeableIndex(index)` returns ture, than `index.compose(otherIndex)` and `otherIndex.compose(index)` should work.
      res = matlabcoder.IndexBase.isVectorableIndex(index) ...
        || matlabcoder.IndexBase.isAllIndex(index) || matlabcoder.IndexBase.isEmptyIndex(index);
    end
    
    function [newStartIndex, newEndIndex] = composeIndexes(startIndex, endIndex, subStartIndex, subEndIndex)
      newStartIndex = startIndex - 1 + subStartIndex;
      if newStartIndex > endIndex
        newStartIndex = -1;
      end
      newEndIndex = startIndex - 1 + subEndIndex;
      if newEndIndex > endIndex
        newEndIndex = endIndex;
      end
    end
    
    function res = checkIndexes(varargin)
      % check whether we pass some elements that is not an index instance
      res = isempty(varargin(~matlabcoder.IndexBase.isIndex(varargin)));
      if ~res
        matlabcoder.Util.throwException('IndexBase:checkIndexes:IllegalArgument', '')
      end
    end
    
    function res = convertToIndex(x)
      if matlabcoder.IndexBase.isIndex(x)
        res = x;
      elseif isnumeric(x) && isscalar(x) && x > 0
        res = matlabcoder.SinglePositionIndex(x);
      elseif isnumeric(x) && isvector(x) && isempty( x(x <= 0))
        res = matlabcoder.PositionIndex(x);
      elseif isa(x,  'function_handle')
        res = matlabcoder.LogicalIndex(x);
      elseif isempty(x)
        res = matlabcoder.EmptyIndex.INSTANCE;
      elseif x == ':'
        res = matlabcoder.AllIndex.INSTANCE;
      else
        matlabcoder.Util.throwException('IndexBase:convertToIndex:IllegalArgument', '')
      end
    end
    
  end
  
end
