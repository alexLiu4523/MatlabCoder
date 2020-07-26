classdef VectorView < matlabcoder.ViewBase
  %VECTORVIEW
  
  methods
    
    function this = VectorView(vectorHandle, index)
      this = this@matlabcoder.ViewBase(vectorHandle, {index});
    end
    
    function res = viewData(this)
      if matlabcoder.IndexBase.isLogicalIndex(this.indexes{1})
        % generates a new matrix according to the function
        res = this.indexes{1}.logicalFunc(this.dataHandle.data);
      else
        res = this.dataHandle.data(this.indexes{1}.toMatlabIndex());
      end
    end
    
    function res = subview(this, subIndex)
      index = this.indexes{1};
      if matlabcoder.IndexBase.isLogicalIndex(index) && matlabcoder.IndexBase.isLogicalIndex(subIndex)
        % generates a new logical matrix
        newLogicalIndex = matlabcoder.LogicalIndex(@(x) index.logicalFunc(x) && subIndex.logicalFunc(x));
        res = matlabcoder.VectorView(this.matrixHandle.data, newLogicalIndex);
        
      else
        if matlabcoder.IndexBase.isVectorableIndex(index) && matlabcoder.IndexBase.isVectorableIndex(subIndex)
          res = matlabcoder.VectorView(this.dataHandle, index.compose(subIndex));
        else
          matlabcoder.Util.throwException('VectorView:viewData:IllegalArgument', 'Illegal argument.');
        end
        
      end
      
    end
    
    function res = eqImpl(this, other)
      res = matlabcoder.VectorView.isVectorView(other) && ...
         this.dataHandle.eqImpl(other.dataHandle) && this.indexes{1} == other.indexes{1};
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
            matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
        end
        
      elseif matlabcoder.MatrixView.isMatrixView(other)
        
      elseif matlabcoder.MatrixHandle.isMartixHandle(other)
        
      elseif numel(other) > 1
        xIndex = this.indexes{1};
        yIndex = this.indexes{2};
        this.matrixHandle.data(xIndex.toVector, yIndex.toVector) = other;
        
      else
        matlabcoder.Util.throwException('MatrixView:assign:IllegalArgument', 'Illegal argument.');
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
          matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
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
      elseif isa(B, 'matlabcoder.MatrixView')
        %region ClassFuncImpl:MatrixView.plus.matrix(this,B,res)
        res = matlabcoder.MatrixOperationValue(this, matlabcoder.MatrixOpertationEnum.PlusMatrix, B);
        % res = this.viewData() + B.viewData();
        %endregion ClassFuncImpl:MatrixView.plus.matrix
      else
        matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
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
    
    function res = isVectorView(obj)
      res = isa(obj, 'matlabcoder.VectorView');
    end
    
  end
  
end
