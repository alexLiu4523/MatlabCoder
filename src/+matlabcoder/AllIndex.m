classdef AllIndex < matlabcoder.IndexBase
  %ALLINDEX
  
  methods
    
    function this = AllIndex()
      this = this@matlabcoder.IndexBase(-1, -1);
    end
    
    % Note: If we specified a index like `:`, it means all the elements of Matrix and we can not get the size of the index.
    
    function res = toVector(this)
      matlabcoder.Util.throwException('AllIndex:toVector:UnsupportedOperation', '');
    end
    
    function res = toMatlabIndex(this)
      res = ':';
    end
    
    function res = length(this)
      matlabcoder.Util.throwException('AllIndex:length:UnsupportedOperation', '');
    end
    
    function res = compose(this, otherIndex)
      res = otherIndex;
    end
    
    function res = eq(this, other)
      res = matlabcoder.IndexBase.isAllIndex(other);
    end
    
  end
  
  properties(Constant)
    INSTANCE = matlabcoder.AllIndex();
    
    % FIXME: Fix error of `Initial values of class types can only be used for reading properties.` 
    %   after calling `matlabcoder.AllIndex.INSTANCE`.
  end
  
  methods(Static = true)
    
%     % TODO： Error in Matlab Coder: This function is not a valid MATLAB method.
%     function res = getInstance()
%       res = matlabcoder.AllIndex.INSTANCE;
%     end

  end
  
end
