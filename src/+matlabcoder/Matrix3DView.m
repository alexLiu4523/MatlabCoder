classdef Matrix3DView < matlabcoder.ViewBase
  %MATRIX3DVIEW
  
  methods
    
    function this = Matrix3DView(dataHandle, varargin)
      this = this@matlabcoder.ViewBase(dataHandle, varargin);
    end
    
    function res = viewData(this)
      if numel(this.indexes) == 1 && matlabcoder.IndexBase.isLogicalIndex(this.indexes{1})
        % generates a new matrix according to the function
        res = this.indexes{1}.logicalFunc(this.dataHandle.data);
      else
        % Note: `cellfun` is not supported in MATLAB coder.
        % realIndexes = cellfun(@(v) v.toVector(), this.indexes, 'UniformOutput', false);
        % res = this.dataHandle.data(realIndexes{:});
        if numel(this.indexes) == 1
          res = this.dataHandle.data(this.indexes{1}.toMatlabIndex());
        elseif numel(this.indexes) == 2
          res = this.dataHandle.data(this.indexes{1}.toMatlabIndex(), this.indexes{2}.toMatlabIndex());
        elseif numel(this.indexes) == 3
          res = this.dataHandle.data(this.indexes{1}.toMatlabIndex(), this.indexes{2}.toMatlabIndex(), this.indexes{3}.toMatlabIndex());
        else
          matlabcoder.Util.throwException('Matrix3DView:viewData:IllegalState', 'Illegal indexes.');
        end
      end
    end
    
    function res = subview(this, varargin)
      % TODO
      if numel(this.indexes) == 1 && numel(varargin) == 1 ...
          && matlabcoder.IndexBase.isLogicalIndex(this.indexes{1}) && matlabcoder.IndexBase.isLogicalIndex(varargin{1})
        logicalIndex = this.indexes{1};
        otherLogicIndex = varargin{1};
        % generates a new logical matrix
        newLogicalIndex = matlabcoder.LogicalIndex(@(x) logicalIndex.logicalFunc(x) && otherLogicIndex.logicalFunc(x));
        res = matlabcoder.MatrixView(this.dataHandle.data, newLogicalIndex);
        
      elseif numel(this.indexes) == 1 && numel(varargin) == 1
        xIndex = this.indexes{1};
        subXIndex = varargin{1};
        if matlabcoder.IndexBase.isVectorableIndex(xIndex) && matlabcoder.IndexBase.isVectorableIndex(subXIndex)
          res = matlabcoder.MatrixView(this.dataHandle, xIndex.compose(subXIndex));
        else
          matlabcoder.Util.throwException('Matrix3DView:viewData:IllegalArgument', 'Illegal argument.');
        end
        
      elseif numel(this.indexes) == 2 && numel(varargin) == 2
        xIndex = this.indexes{1};
        yIndex = this.indexes{2};
        subXIndex = varargin{1};
        subYIndex = varargin{2};
        if matlabcoder.IndexBase.isVectorableIndex(xIndex) && matlabcoder.IndexBase.isVectorableIndex(yIndex) ...
            && matlabcoder.IndexBase.isVectorableIndex(subXIndex) && matlabcoder.IndexBase.isVectorableIndex(subYIndex)
          res = matlabcoder.MatrixView(this.dataHandle, xIndex.compose(subXIndex), yIndex.compose(subYIndex));
        else
          matlabcoder.Util.throwException('Matrix3DView:viewData:IllegalArgument', 'Illegal argument.');
        end
        
      elseif numel(this.indexes) == 3 && numel(varargin) == 3
        xIndex = this.indexes{1};
        yIndex = this.indexes{2};
        zIndex = this.indexes{3};
        subXIndex = varargin{1};
        subYIndex = varargin{2};
        subZIndex = varargin{3};
        if matlabcoder.IndexBase.isVectorableIndex(xIndex) && matlabcoder.IndexBase.isVectorableIndex(yIndex) ...
            && matlabcoder.IndexBase.isVectorableIndex(zIndex) && matlabcoder.IndexBase.isVectorableIndex(subXIndex) ...
            && matlabcoder.IndexBase.isVectorableIndex(subYIndex) && matlabcoder.IndexBase.isVectorableIndex(subZIndex)
          res = matlabcoder.MatrixView(this.dataHandle, xIndex.compose(subXIndex), yIndex.compose(subYIndex), zIndex.compose(subZIndex));
        else
          matlabcoder.Util.throwException('Matrix3DView:viewData:IllegalArgument', 'Illegal argument.');
        end
        
      else
        matlabcoder.Util.throwException('Matrix3DView:viewData:IllegalArgument', 'Illegal argument.');
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
      if matlabcoder.MatrixOperationValue.isMatrixOperationValue(other)
        switch(other.opertation)
          case matlabcoder.MatrixOpertationEnum.PlusScalar
            
          case matlabcoder.MatrixOpertationEnum.PlusMatrix
            view = this.viewData();
            view.assignImpl(other.operandA + other.operandB);
            res = view;
            
          otherwise
            matlabcoder.Util.throwException('Matrix3DView:assignImpl:IllegalArgument', 'Illegal argument.');
        end
        
      elseif matlabcoder.MatrixView.isMatrixView(other)
        
      elseif matlabcoder.MatrixHandle.isMartixHandle(other)
        
      elseif numel(other) > 1
        xIndex = this.indexes{1};
        yIndex = this.indexes{2};
        this.dataHandle.data(xIndex.toVector, yIndex.toVector) = other;
        
      else
        matlabcoder.Util.throwException('Matrix3DHandle:assign:IllegalArgument', 'Illegal argument.');
      end
      
    end
    
    % this = this op operand => this.operateSelfImpl(op, operand)
    function res = operateSelfImpl(this, operation, operand)
      switch(operation)
        case matlabcoder.MatrixOpertationEnum.PlusScalar
          
        case matlabcoder.MatrixOpertationEnum.PlusMatrix
          view = this.viewData();
          view.assignImpl(view + operand);
          res = view;
          
        otherwise
          matlabcoder.Util.throwException('Matrix3DView:assignImpl:IllegalArgument', 'Illegal argument.');
      end
    end
    
    %     function res = plusMatrixAssignSelf(this, operand)
    %       this = this + operand;
    %       res = this;
    %     end
    
    % https://www.mathworks.com/help/matlab/ref/plus.html
    function res = plus(this, B)
      coder.inline('never');
      if isscalar(B)
        %region ClassFuncImpl:MatrixView.plus.scalar(this,B,res)
        res = matlabcoder.MatrixOperationValue(this, matlabcoder.MatrixOpertationEnum.PlusScalar, B);
        % res = this.viewData() + B;
        %endregion ClassFuncImpl:MatrixView.plus.scalar
      elseif isa(B, 'matlabcoder.Matrix3DView')
        %region ClassFuncImpl:MatrixView.plus.matrix(this,B,res)
        res = matlabcoder.MatrixOperationValue(this, matlabcoder.MatrixOpertationEnum.PlusMatrix, B);
        % res = this.viewData() + B.viewData();
        %endregion ClassFuncImpl:MatrixView.plus.matrix
      else
        matlabcoder.Util.throwException('Matrix3DView:plus:IllegalArgument', 'Illegal argument.');
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
    
    function res = isMatrix3DView(obj)
      res = isa(obj, 'matlabcoder.Matrix3DView');
    end
    
  end
  
end
