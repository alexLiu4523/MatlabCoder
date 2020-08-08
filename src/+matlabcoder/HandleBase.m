classdef HandleBase < handle
  
  properties
    data
  end
  
  methods
    
    function this = HandleBase(arg, varargin)
      % see [[https://ww2.mathworks.cn/help/matlab/ref/varargin.html]]
      if isempty(varargin) % receive olny one argument
        if ~isscalar(arg) % receive data
          this.data = arg;
        elseif isa(arg, 'matlabcoder.HandleBase') % receive a handle, just copy its data
          this.data = arg.data;
        elseif isa(arg, 'function_handle') % receive a data create function
          this.data = arg();
        else
          throw(MException('HandleBase:Constructor:IllegalArgument', 'Can not create a HandleBase of type %s', class(arg)));
        end
      else % receive more than one argument
        createMethodEnum = arg;
        switch(createMethodEnum)
          case matlabcoder.MatrixCreationMethodEnum.Zeros
            this.data = zeros(varargin{:});
          case matlabcoder.MatrixCreationMethodEnum.Ones
            this.data = ones(varargin{:});
          case matlabcoder.MatrixCreationMethodEnum.Rand
            this.data = ones(varargin{:});
          case matlabcoder.MatrixCreationMethodEnum.True
            this.data = true(varargin{:});
          case matlabcoder.MatrixCreationMethodEnum.False
            this.data = false(varargin{:});
          case matlabcoder.MatrixCreationMethodEnum.Eye
            this.data = eye(varargin{:});
          case matlabcoder.MatrixCreationMethodEnum.Diag
            this.data = diag(varargin{:});
            % TODO Add other constructor
          otherwise
            throw(MException('HandleBase:constructor:IllegalArgument', 'Unhandled matrix createion method: %s', class(createMethodEnum)));
        end
      end
    end
    
    % @see [[https://www.mathworks.com/help/matlab/matlab_oop/implementing-operators-for-your-class.html Operator Overloading]]
    
    % Note: `subsref` is not supported in MATLAB Coder
    % @see [[https://www.mathworks.com/help/matlab/ref/subsref.html]]
    %     function res = subsref(this, s)
    %       % Note: If we call `matrixView.matrixHandle.data(:)`, then `s` is a `1x3 struct`
    %       if isscalar(s) && isa(s.type, 'char') && strcmp(s.type, '()')
    %         res = this.subview(this, s.subs{:});
    %       else
    %         res = builtin('subsref', this, s);
    %       end
    %     end
    
    % S — Indexing structure Indexing structure, passed by MATLAB as the indexing substruct for the indexing expression that caused the call to subsref. This
    % structure has these fields:
    %   type – Character vector or string scalar containing (), {}, or ., specifying the subscript type.
    %   subs – Cell array, character vector, or string scalar
    %   containing the actual subscripts.
    % https://www.mathworks.com/help/matlab/ref/substruct.html
    %
    % Examples: h(2), h(2:2) => s.type = '()', s.subs = 1×1 cell 数组 {[2]}, s.subs{1} = 2 h(2:4) => s.type = '()', s.subs = 1×1 cell 数组 {1×3 double}, s.subs{1} =
    % [2 3 4] h(2:4, 3:4) => s.type = '()', s.subs = 1×2 cell 数组 {1×3 double} {1×2 double}, s.subs{1} = [2 3 4], s.subs{1} = [3, 4] ? h(1:end, :) => s.type =
    % '()', s.subs = 1×2 cell 数组 {[1]} {':'}
    
    % A = subsasgn(A,S,B) called by MATLAB® for the syntax A(i) = B, A{i} = B, or A.i = B when A is an object.
    % https://www.mathworks.com/help/matlab/ref/subsasgn.html
    %
    function res = subsasgn(this, s, B)
      if isscalar(s) && isa(s.type, 'char') && strcmp(s.type, '()')
        res = this.subsasgnImplOfIndex(s.subs, B);
      else
        res = builtin('subsasgn', this, s, B);
      end
    end
    
    function this = subsasgnImplOfIndex(this, subs, B)
      coder.inline('never');
      this.data(subs{:}) = matlabcoder.Util.getOperandData(B);
      % thisView = this.subview(subs);
      % thisView.assign(B);
    end
    
    function res = eq(this, other)
      res = this.eqImpl(other);
    end
    
  end
  
  methods(Abstract)
    
    subview(this, varargin);
    % gets a view of handle's part data according to given indexes
    
    fullView(this);
    % gets a view of handle's all data
    
    eqImpl(this, other);
    
  end
  
  methods(Static)
    
    function res = isHandle(obj)
      res = isa(obj, 'matlabcoder.HandleBase');
    end
    
  end
  
end

