classdef SinglePositionIndex < matlabcoder.IndexBase
  %SINGLEPOSITIONINDEX Single position index
  %   
  
  methods
    
    function this = SinglePositionIndex(pos)
      this = this@matlabcoder.IndexBase(pos, pos);
    end
    
    function pos = getPosition(this)
      pos = this.startIndex;
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
      if matlabcoder.IndexBase.isAllIndex(otherIndex)
        res = this;
        
      elseif matlabcoder.IndexBase.isEmptyIndex(otherIndex)
        res = otherIndex;
        
      elseif matlabcoder.IndexBase.isUnitSpacedIndex(otherIndex) ||  matlabcoder.IndexBase.isRegularlySpacedIndex(otherIndex)
        % A(x)(a:b) || A(x)(a:2:b), where (a:b) and (a:2:b) is not empty
        if otherIndex.startIndex == 1
          res = this;
        else
          res = matlabcoder.EmptyIndex.INSTANCE;
        end

      elseif matlabcoder.IndexBase.isSinglePositionIndex(otherIndex)
        if otherIndex.getPosition == 1
          res = this;
        else
          res = matlabcoder.EmptyIndex.INSTANCE;
        end
        
      else
        matlabcoder.Util.throwException('SinglePositionIndex:compose:IllegalArgument', '');
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
