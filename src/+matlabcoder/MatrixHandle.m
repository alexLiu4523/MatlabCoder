classdef MatrixHandle < matlabcoder.HandleBase
  
  methods
    
    function this = MatrixHandle(arg, varargin)
      this = this@matlabcoder.HandleBase(arg, varargin{:});
      if ~ismatrix(this.data)
        throw(MException('MatrixHandle:Constructor:IllegalArgument', 'Can not create a MatrixHandle with data type %s', class(arg)));
      end
    end

    function res = subview(this, varargin)
      % allow 1 or 2 indexes
      if nargin == 2 || nargin == 3 
        res = matlabcoder.MatrixView(this, varargin{:});
      else
        throw(MException('MatrixHandle:subview:IllegalArgument', 'Unhandled subview index type.'));
      end
    end
    
    function res = eqImpl(this, other)
      % TODO should be reference equal ?
      if isa(other, 'matlabcoder.MatrixHandle')
        res = isequal(this.data, other.data);
      else
        res = false;
      end
    end
    
  end
  
  methods(Static)
    
    function res = isMartixHandle(obj)
      res = isa(obj, 'matlabcoder.MatrixHandle');
    end
    
  end
  
end