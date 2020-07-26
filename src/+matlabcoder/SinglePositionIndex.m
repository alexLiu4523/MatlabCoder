classdef SinglePositionIndex < matlabcoder.IndexBase
  %SINGLEPOSITIONINDEX Single position index
  %   
  
  methods
    
    function this = SinglePositionIndex(pos)
      this = this@matlabcoder.IndexBase(pos, pos);
    end
    
    function res = toVector(this)
      res = this.startIndex : this.endIndex;
    end
    
    function res = toMatlabIndex(this)
      res = this.toVector();
    end
    
    function res = length(this)
      res =  1;
    end
    
    % TODO
    function res = compose(otherIndex)
      if isa(otherIndex, 'matlabcoder.AllIndex')
        res = this;
      elseif isa(otherIndex, 'matlabcoder.UnitSpacedIndex')
        if otherIndex.startIndex == 1 % && otherIndex.endIndex >= 1
          res = this;
        else
          res = matlabcoder.EmptyIndex.INSTANCE;
        end
      elseif isa(otherIndex, 'matlabcoder.RegularlySpacedIndex')
         if otherIndex.startIndex == 1 % && otherIndex.endIndex >= 1
          res = this;
        else
          res = matlabcoder.EmptyIndex.INSTANCE;
        end
      else
        throw(MException('SinglePositionIndex:compose:IllegalArgument', ''));
      end
    end
    
  end
  
  methods(Static)
      
    function res = of(singlePosition)
      assert(singlePosition > 0);
      
      res = matlabcoder.SinglePositionIndex(singlePosition);      
    end
    
  end
  
end
