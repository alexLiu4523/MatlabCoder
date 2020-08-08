classdef UnitSpacedIndex < matlabcoder.IndexBase
  %UNITSPACEDINDEX Unit-spaced index
  %   x = j:k creates a unit-spaced vector x with elements [j,j+1,j+2,...,j+m]
  %   where m = fix(k-j). If j and k are both integers, then this is simply [j,j+1,...,k].
  
  methods
    
    function this = UnitSpacedIndex(startIndex, endIndex)
      this = this@matlabcoder.IndexBase(startIndex, endIndex);
      
      assert(startIndex > 0 && startIndex <= endIndex);
    end
    
    function res = eqImpl(this, other)
      res = matlabcoder.IndexBase.isUnitSpacedIndex(other) ...
        && this.startIndex == other.startIndex && this.endIndex == other.endIndex;
    end
    
    function res = toVector(this)
      res = this.startIndex : this.endIndex;
    end
    
    function res = toMatlabIndex(this)
      res = this.toVector();
    end
    
    function res = length(this)
      res = this.endIndex - this.startIndex + 1;
    end
    
    function res = toRegularlySpacedIndex(this)
      res = matlabcoder.RegularlySpacedIndex(this.startIndex, this.endIndex, 1);
    end
    
    function res = compose(this, otherIndex)
      if matlabcoder.IndexBase.isAllIndex(otherIndex)
        res = this;
        
      elseif matlabcoder.IndexBase.isEmptyIndex(otherIndex)
        res = otherIndex;
        
      elseif matlabcoder.IndexBase.isUnitSpacedIndex(otherIndex)
        [newStartIndex, newEndIndex] = ...
          matlabcoder.IndexBase.composeIndexes(this.startIndex, this.endIndex, otherIndex.startIndex, otherIndex.endIndex);
        if newStartIndex > 0
          res = matlabcoder.UnitSpacedIndex(newStartIndex, newEndIndex);
        else
          res = matlabcoder.EmptyIndex.INSTANCE;
        end
        
      elseif matlabcoder.IndexBase.isRegularlySpacedIndex(otherIndex)
        [newStartIndex, newEndIndex] = ...
          matlabcoder.IndexBase.composeIndexes(this.startIndex, this.endIndex, otherIndex.startIndex, otherIndex.endIndex);
        if newStartIndex > 0
          res = matlabcoder.RegularlySpacedIndex(newStartIndex, newEndIndex, otherIndex.inc);
        else
          res = matlabcoder.EmptyIndex.INSTANCE;
        end
     
      elseif matlabcoder.IndexBase.isSinglePositionIndex(otherIndex)
        newPosition = this.startIndex - 1 + otherIndex.getPosition();
        if newPosition <= this.endIndex
          res = matlabcoder.SinglePositionIndex(newPosition);
        else
          res = matlabcoder.EmptyIndex.INSTANCE;
        end
        
      else
        matlabcoder.Util.throwException('UnitSpacedIndex:compose:IllegalArgument', '');
      end
    end
    
  end
  
end
