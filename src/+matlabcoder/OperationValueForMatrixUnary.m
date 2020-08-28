classdef OperationValueForMatrixUnary < matlabcoder.OperationValue
  %OperationValueForMatrixMatrix
  
  properties
    operandA
    operation
  end
  
  methods
    
    function this = OperationValueForMatrixUnary(operandA, operation)
      this.operandA = operandA;
      this.operation = operation;
    end
    
    function res = compute(this)
      coder.inline('never');
      
      switch(this.operation)
        case matlabcoder.MatrixOperationEnum.PlusMatrix
          res = this.operandA.viewData();
          
        otherwise
          res = 1;
      end
    end
    
  end
  
  methods(Static)
    
  end
  
end
