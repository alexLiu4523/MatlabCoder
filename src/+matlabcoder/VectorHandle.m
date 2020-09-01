classdef VectorHandle < matlabcoder.HandleBase
  
  methods
    
    function this = VectorHandle(arg, varargin)
      this = this@matlabcoder.HandleBase(arg, varargin{:});
      if ~isvector(this.data)
        throw(MException('VectorHandle:Constructor:IllegalArgument', 'Can not create a VectorHandle with data type %s', class(arg)));
      end
    end
    
    % Note: isvector([1 2]) and isvector([1; 2]) both return true, and isvector([1 2;3 4]) returns false

    function res = subview(this, varargin)
      % allow 0(same as `fullView`) or 1 index
      if nargin == 1
        res = this.fullView();
      elseif nargin == 2
        res = matlabcoder.VectorView(this, varargin{:});
      else
        throw(MException('VectorHandle:subview:IllegalArgument', 'Unhandled subview index type.'));
      end
    end
    
    function res = fullView(this)
      res = this.subview(matlabcoder.AllIndex.INSTANCE);
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

