classdef EmptyIndex < matlabcoder.IndexBase
  %EMPTYINDEX
  
  methods
    
    function this = EmptyIndex()
      this = this@matlabcoder.IndexBase(-1, -1);
    end
    
    function res = toVector(this)
      res = [];
    end
    
    function res = toMatlabIndex(this)
      res = [];
    end
    
    function res = length(this)
      res = 0;
    end
    
    function res = compose(this, otherIndex)
      res = this;
    end
    
  end
  
  properties(Constant)
    INSTANCE = matlabcoder.EmptyIndex();
  end
  
end
