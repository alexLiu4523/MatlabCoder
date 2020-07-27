classdef OperationValue
  %OperationValue
  
  properties
    operandA
    opertation
    operandB
  end
  
  methods
    
    function this = OperationValue(operandA, operation, operandB)
      this.operandA = operandA;
      this.opertation = operation;
      this.operandB = operandB;
    end
    
    function res = compute(this)
      % perform operation according to operandA's type and then the operation
      if matlabcoder.MatrixView.isMatrixView(this.operandA)
        switch(this.opertation)
          case matlabcoder.MatrixOpertationEnum.PlusScalar
            res = this.operandA.viewData() + this.operandB;
          case matlabcoder.MatrixOpertationEnum.PlusMatrix
            res = this.operandA.viewData() + this.operandB.viewData();
            
          otherwise
            
        end
        
      elseif matlabcoder.VectorView.isVectorView(this.operandA)
        % TODO
        
      elseif matlabcoder.Matrix3DView.isMatrix3DView(this.operandA)
        % TODO
        
      elseif isscalar(this.operandA)
        
      else
        matlabcoder.Util.throwException('OperationValue:compute:UnsupportedOperation', '');
      end
      
    end
    
  end
  
  methods(Static)
    
    function res = isOperationValue(obj)
      res = isa(obj, 'matlabcoder.OperationValue');
    end
    
  end
  
end
