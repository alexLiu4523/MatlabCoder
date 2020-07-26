classdef UnitSpacedIndex < matlabcoder.IndexBase
  %UNITSPACEDINDEX Unit-spaced index
  %   x = j:k creates a unit-spaced vector x with elements [j,j+1,j+2,...,j+m]
  %   where m = fix(k-j). If j and k are both integers, then this is simply [j,j+1,...,k].
  
  methods
    
    function this = UnitSpacedIndex(startIndex, endIndex)
      this = this@matlabcoder.IndexBase(startIndex, endIndex);
      
      assert(startIndex > 0 && startIndex <= endIndex);
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
    
    % TODO
    function res = compose(otherIndex)
      if isa(otherIndex, 'matlabcoder.AllIndex')
        res = this;
      elseif isa(otherIndex, 'matlabcoder.UnitSpacedIndex')
        newStartIndex = this.startIndex - 1 + otherIndex.startIndex;
        newEndIndex = this.startIndex - 1 - otherIndex.endIndex;
        if newEndIndex > this.endIndex
          newEndIndex = this.endIndex;
        end
        res = matlabcoder.UnitSpacedIndex(newStartIndex, newEndIndex);
      elseif isa(otherIndex, 'matlabcoder.RegularlySpacedIndex')
        newStartIndex = this.startIndex - 1 + otherIndex.startIndex;
        newEndIndex = this.startIndex - 1 - otherIndex.endIndex;
        if newEndIndex > this.endIndex
          newEndIndex = this.endIndex;
        end
        res = matlabcoder.UnitSpacedIndex(newStartIndex, newEndIndex, otherIndex.inc);
      else
        throw(MException('UnitSpacedIndex:compose:IllegalArgument', ''));
      end
    end
    
  end
  
end
