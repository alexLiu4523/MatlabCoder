classdef MatrixView < matlabcoder.ViewBase
  %MATRIXVIEW
  
  methods
    
    function this = MatrixView(matrixHandle, varargin)
      this = this@matlabcoder.ViewBase(matrixHandle, varargin);
    end
    
    function res = viewData(this)
      if numel(this.indexes) == 1 && matlabcoder.IndexBase.isLogicalIndex(this.indexes{1})
        % generate a new matrix according to the function
        res = this.indexes{1}.logicalFunc(this.dataHandle.data);
      else
        % Note: `cellfun` is not supported in MATLAB coder.
        % realIndexes = cellfun(@(v) v.toVector(), this.indexes, 'UniformOutput', false);
        % res = this.dataHandle.data(realIndexes{:});
        if numel(this.indexes) == 1
          res = this.dataHandle.data(this.indexes{1}.toMatlabIndex());
        elseif numel(this.indexes) == 2
          res = this.dataHandle.data(this.indexes{1}.toMatlabIndex(), this.indexes{2}.toMatlabIndex());
        else
          % throw(MException('MatrixView:viewData:IllegalState', 'Illegal indexes.'));
          matlabcoder.Util.throwException('MatrixView:viewData:IllegalState', 'Illegal indexes.');
        end
      end
      
      %       if numel(this.indexes) == 1
      %         logicalIndex = this.indexes{1};
      %         if isa(this.indexes, 'matlabcoder.LogicalIndex')
      %           % generates a new matrix according to the function
      %           res = logicalIndex.logicalFunc(this.matrixHandle.data);
      %         else
      %           throw(MException('MatrixView:viewData:IllegalArgument', 'Illegal argument.'));
      %         end
      %       elseif numel(this.indexes) == 2
      %         xIndex = this.indexes{1};
      %         yIndex = this.indexes{2};
      %         if matlabcoder.IndexBase.isVectorableIndex(xIndex) && matlabcoder.IndexBase.isVectorableIndex(yIndex)
      %           res = this.dataHandle.data(xIndex.toVector, yIndex.toVector);
      %         else
      %           throw(MException('MatrixView:viewData:IllegalArgument', 'Illegal argument.'));
      %         end
      %       else
      %         throw(MException('MatrixView:viewData:IllegalArgument', 'Illegal argument.'));
      %       end
    end
    
    function res = matlabIndexes(this)
      res = {this.indexes{1}.toMatlabIndex(), this.indexes{2}.toMatlabIndex()};
    end
    
    function res = subview(this, varargin)
      if numel(this.indexes) == 1 && numel(varargin) == 1 ...
          && matlabcoder.IndexBase.isLogicalIndex(this.indexes{1}) && matlabcoder.IndexBase.isLogicalIndex(varargin{1})
        logicalIndex = this.indexes{1};
        otherLogicIndex = varargin{1};
        % generate a new logical matrix
        newLogicalIndex = matlabcoder.LogicalIndex(@(x) logicalIndex.logicalFunc(x) && otherLogicIndex.logicalFunc(x));
        res = matlabcoder.MatrixView(this.matrixHandle.data, newLogicalIndex);
        
      elseif numel(this.indexes) == 1 && numel(varargin) == 1
        xIndex = this.indexes{1};
        subXIndex = varargin{1};
        if xIndex.isComposeable() && subXIndex.isComposeable()
          res = matlabcoder.MatrixView(this.matrixHandle, xIndex.compose(subXIndex));
        else
          matlabcoder.Util.throwException('MatrixView:subview:IllegalArgument', 'Illegal argument.');
        end
        
      elseif numel(this.indexes) == 2 && numel(varargin) == 2
        xIndex = this.indexes{1};
        yIndex = this.indexes{2};
        subXIndex = varargin{1};
        subYIndex = varargin{2};
        if xIndex.isComposeable() && subXIndex.isComposeable() ...
            && subXIndex.isComposeable() && subYIndex.isComposeable()
          res = matlabcoder.MatrixView(this.dataHandle, xIndex.compose(subXIndex), yIndex.compose(subYIndex));
        else
          matlabcoder.Util.throwException('MatrixView:viewData:IllegalArgument', 'Illegal argument.');
        end
        
      else
        matlabcoder.Util.throwException('MatrixView:viewData:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = eqImpl(this, other)
      if isa(other, 'matlabcoder.MatrixView')
        if this.indexCount == 1 && other.indexCount == 1
          res = this.dataHandle.eqImpl(other.dataHandle) && (this.indexes{1} == other.indexes{1});
        elseif this.indexCount == 2 && other.indexCount == 2
          res = this.dataHandle.eqImpl(other.dataHandle) && (this.indexes{1} == other.indexes{1}) && (this.indexes{2} == other.indexes{2});
        else
          res = false;
        end
      else
        res = false;
      end
    end
    
    % this = other => this.assignImpl(other)
    function res = assignImpl(this, other)
      
      if matlabcoder.OperationValue.isOperationValue(other)
        switch(other.operation)
          case matlabcoder.MatrixOperationEnum.PlusScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) + other.operandB(scalar) =>
              visplstub.Stub_Vsip_SMAdd(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.MatrixOperationEnum.PlusMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) + other.operandB(view)
              visplstub.Stub_Vsip_MAdd(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.Times
            % Add other cases
            
          otherwise
            matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
        end
        
      elseif matlabcoder.MatrixView.isMatrixView(other)
        this.dataHandle.data(this.matlabIndexes{:}) = other.viewData();
        
      elseif matlabcoder.MatrixHandle.isMartixHandle(other)
        this.dataHandle.data(this.matlabIndexes{:}) = other.data;
        
      elseif matlabcoder.Util.isNumericMatrix(other)
        % other is a builtin numeric matrix
        this.dataHandle.data(this.matlabIndexes{:}) = other;
        
      elseif matlabcoder.Util.isNumericScalar(other)
        % other is a scalar
        this.dataHandle.data(this.matlabIndexes{:}) = other;
        
      else
        matlabcoder.Util.throwException('MatrixView:assign:IllegalArgument', 'Illegal argument.');
      end
      
      res = this;
      
    end
    
    % this = this op operand => this.operateSelfImpl(op, operand)
    function res = operateSelfImpl(this, operation, operand)
      switch(operation)
        case matlabcoder.MatrixOperationEnum.PlusScalar
          
        case matlabcoder.MatrixOperationEnum.PlusMatrix
          if matlabcoder.MatrixView.isMatrixView(operand) && matlabcoder.MatrixView.isMatrixView(operand)
            % this(view) = this(view) + operand(view)
            visplstub.Stub_Vsip_MAdd(this, operand, this);
          else
            matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
          end
          
        case matlabcoder.MatrixOperationEnum.Times
          % this(view) = other.operandA(view) .* other.operandB(scalar)
          % TODO
          visplstub.Stub_Vsip_SMMul_Double(operand, this, this);
          
        otherwise
          matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
      end
      
      res = this;
    end
    
    % https://www.mathworks.com/help/matlab/ref/plus.html
    function res = plus(this, B)
      coder.inline('never');
      if matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.PlusScalar, B);
      elseif matlabcoder.MatrixView.isMatrixView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.PlusMatrix, B);
      else
        matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    % Element-wise multiplication, A .* b
    function res = times(this, b)
      coder.inline('never');
      if ~isscalar(b)
        matlabcoder.Util.throwException('MatrixView:times:IllegalArgument', 'b should be scalar.');
      end
      
      if isfloat(b)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Times, b);
        
      else
        res = matlabcoder.ViewBase.throwForUnsupportOperation();
      end
      
    end
    
    function res = min(this)
      res = -1;
    end
    
    function res = max(this)
      res = 1;
    end
    
  end
  
  methods(Static)
    
    function res = isMatrixView(obj)
      res = isa(obj, 'matlabcoder.MatrixView');
    end
    
  end
  
end
