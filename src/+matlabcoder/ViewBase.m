classdef ViewBase
  %ViewBase An interface of view.
  
  properties
    dataHandle
    indexes % a cell array that stores indexes
  end
  
  methods
    
    function this = ViewBase(handle, indexes)
      if ~isa(handle, 'matlabcoder.HandleBase')
        throw(MException('MatrixHandle:Constructor:IllegalArgument', 'Handle type error: %s.', class(handle)));
      end
      
      this.dataHandle = handle;
      this.indexes = indexes;
    end
    
    function res = indexCount(this)
      res = numel(this.indexes);
    end
    
    function res = assign(this, B)
      if matlabcoder.OperationValue.isOperationValue(B) && this == B.operandA
        % handle self assignment like `A = A + B`
        res = this.operateSelfImpl(B.operation, B.operandB);
      else
        res = this.assignImpl(B);
      end
    end
    
    function res = subsasgn(this, s, B)
      if isscalar(s) && isa(s.type, 'char') && strcmp(s.type, '()')
        res = this.subsasgnImplOfIndex(s.subs, B);
      else
        res = builtin('subsasgn', this, s, B);
      end
    end
    
    function res = subsasgnImplOfIndex(this, subs, B)
      coder.inline('never');
      if (isa(B, 'matlabcoder.MatrixOperationValue'))
        if matlabcoder.OperationValue.isOperationValue(B) && ...
            matlabcoder.ViewBase.isView(B.operandA) && subs == B.operandA.subs
          % handle self-assignment like A(1, 2) = A(1, 2) + B
          % TODO: Check
          view = this.subview(subs{:});
          view.operateSelfImpl(B.operation, B.operandB);
          res = view;
        end
      else
        % TODO: Check
        view = this.subview(subs{:});
        view.assignImpl(B);
        res = view;
      end
    end
    
    % overloaded operations that forwards to implementations
    
    function res = eq(this, other)
      res = this.eqImpl(other);
    end
    
    % plus(this, B);
    
    
    
  end
  
  methods(Abstract)
    
    viewData(this);
    
    % viewInstance(index1, index2, ...) => viewInstance.subview(index1, index2, ...)
    subview(this, varargin);
    
    % this = other => this.assignImpl(other)
    assignImpl(this, other);
    
    % this = this op operand => this.operateSelfImpl(op, operand)
    operateSelfImpl(this, operation, operand);
    

    % implementations of overloaded operations
    eqImpl(this, other)
    
    
    % MATLAB builtin functions for vectores/matrices
    min(this);
    max(this);
    
  end
  
  methods(Static)
    
    function res = isView(obj)
      res = isa(obj, 'matlabcoder.ViewBase');
    end
    
  end
  
end