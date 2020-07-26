classdef VectorHandle < matlabcoder.HandleBase
  
  methods
    
    function this = VectorHandle(arg, index)
      this = this@matlabcoder.HandleBase(arg, {index});
      if ~isvector(this.data)
        throw(MException('VectorHandle:Constructor:IllegalArgument', 'Can not create a VectorHandle with data type %s', class(arg)));
      end
    end

    function res = subview(this, index)
      % only allow 1 index
      res = matlabcoder.MatrixView(this, {index});
    end
    
    function res = eqImpl(this, other)
      % TODO should be reference equal ?
      if isa(other, 'matlabcoder.VectorHandle')
        res = isequal(this.data, other.data);
      else
        res = false;
      end
    end
    
  end
  
  methods(Static)
    
    function res = isVectorHandle(obj)
      res = isa(obj, 'matlabcoder.VectorHandle');
    end
    
  end
  
end

