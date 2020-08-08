classdef Matrix3DHandle < matlabcoder.HandleBase
  
  methods
    
    function this = Matrix3DHandle(arg, varargin)
      this = this@matlabcoder.HandleBase(arg, varargin{:});
      if ndims(this.data) ~= 3
        % throw(MException('Matrix3DHandle:Constructor:IllegalArgument', 'Can not create a Matrix3DHandle with data type %s', class(arg)));
        matlabcoder.Util.throwException('Matrix3DHandle:Constructor:IllegalArgument', 'Can not create a Matrix3DHandle with data type %s', class(arg));
      end
    end
    
    function res = subview(this, varargin)
      % allow 1, 2 or 3 indexes
      if nargin == 2 || nargin == 3 || nargin == 4
        res = matlabcoder.Matrix3DView(this, varargin);
      else
        % throw(MException('Matrix3DHandle:subview:IllegalArgument', 'Unhandled subview index type.'));
        matlabcoder.Util.throwException('Matrix3DHandle:subview:IllegalArgument', 'Unhandled subview index type.');
      end
    end
    
    function res = fullView(this)
      res = this.subview(matlabcoder.AllIndex.INSTANCE, matlabcoder.AllIndex.INSTANCE, matlabcoder.AllIndex.INSTANCE);
    end
    
    function res = eqImpl(this, other)
      % TODO should be reference equal ?
      if isa(other, 'matlabcoder.Matrix3DHandle')
        res = isequal(this.data, other.data);
      else
        res = false;
      end
    end
    
  end
  
  methods(Static)
    
    function res = isMartix3DHandle(obj)
      res = isa(obj, 'matlabcoder.Matrix3DHandle');
    end
    
  end
  
end
