classdef LogicalIndex < matlabcoder.IndexBase
  %LOGICALINDEX
  
  properties
    logicalFunc % = @(x) true;
  end
  
  methods
    
    function this = LogicalIndex(logicalFunc)
      this = this@matlabcoder.IndexBase(-1, -1);
      this.logicalFunc = logicalFunc;
    end
    
    function res = toVector(this)
      matlabcoder.Util.throwException('LogicalIndex:toVector:UnsupportedOperation', '');
    end
    
    function res = toMatlabIndex(this)
      %TODO
      matlabcoder.Util.throwException('LogicalIndex:toMatlabIndex:UnsupportedOperation', '');
    end
    
    function res = length(this)
      matlabcoder.Util.throwException('LogicalIndex:length:UnsupportedOperation', '');
    end
    
    function res = compose(this, otherIndex)
      % TODO Should we allow `>1` compose `1:3` ?
      matlabcoder.Util.throwException('LogicalIndex:compose:UnsupportedOperation', '');
    end
    
  end
  
end

