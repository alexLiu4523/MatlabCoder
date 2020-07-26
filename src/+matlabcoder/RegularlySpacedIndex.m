classdef RegularlySpacedIndex < matlabcoder.IndexBase
  %UNITSPACEDINDEX Regularly-spaced index
  %   x = j:i:k creates a regularly-spaced vector x using i as the increment between elements.
  %   The vector elements are roughly equal to [j,j+i,j+2*i,...,j+m*i] where m = fix((k-j)/i).
  %   However, if i is not an integer, then floating point arithmetic plays a role in determining
  %   whether colon includes the endpoint k in the vector, since k might not be exactly equal to j+m*i.
  %   If you specify nonscalar arrays, then MATLAB interprets j:i:k as j(1):i(1):k(1).
  
  properties
    inc
  end
  
  methods
    
    % Note: We do not allow indexes like `1:0`, which leads to empty array.
    % These indexes should use `EmptyIndex`.
    
    function this = RegularlySpacedIndex(startIndex, endIndex, inc)
      this = this@matlabcoder.IndexBase(startIndex, endIndex);
      this.inc = inc;
      
      assert(inc ~= 0);
      if inc > 0
        assert(startIndex > 0 && startIndex <= endIndex);
      else
        assert(endIndex > 0 && startIndex >= endIndex);
      end
      
    end
    
    function res = toVector(this)
      res = this.startIndex : this.inc : this.endIndex;
    end
    
    function res = toMatlabIndex(this)
      res = this.toVector();
    end
    
    function res = length(this)
      if this.inc > 0
        res = ceil((this.endIndex - this.startIndex + 1) / this.inc);
      else
         res = ceil((this.startIndex - this.endIndex + 1) / (-this.inc));
      end
    end
    
    % TODO
    function res = compose(otherIndex)
      if isa(otherIndex, 'matlabcoder.AllIndex')
        res = this;
      elseif isa(otherIndex, 'matlabcoder.UnitSpacedIndex')
        newStartIndex = this.startIndex + otherIndex.startIndex - 1;
        newEndIndex = 1; % TODO
        res = matlabcoder.UnitSpacedIndex(newStartIndex + newEndIndex);
      elseif isa(otherIndex, 'matlabcoder.RegularlySpacedIndex')
        throw(MException('RegularlySpacedIndex:compose:', '')); % TODO
      else
        throw(MException(''));
      end
    end
    
  end
  
  methods(Static)
    
    function res = of(startIndex, endIndex, inc)
      assert(inc ~= 0);
      
      if (inc > 0 && startIndex > endIndex) || (inc < 0 && startIndex < endIndex)
        res = matlabcoder.EmptyIndex.INSTANCE;
      else
        res = matlabcoder.RegularlySpacedIndex(startIndex, endIndex, inc);
      end
      
    end
    
  end
  
end

