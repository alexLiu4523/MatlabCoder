classdef OperationValueForMatrixMatrix < matlabcoder.OperationValue
  %OperationValueForMatrixMatrix
  
  properties
    operandA
    operation
    operandB
  end
  
  methods
    
    function this = OperationValueForMatrixMatrix(operandA, operation, operandB)
      this.operandA = operandA;
      this.operation = operation;
      this.operandB = operandB;
    end
    
    function res = compute(this)
      coder.inline('never');
      
      switch(this.operation)
        case matlabcoder.MatrixOperationEnum.PlusMatrix
          res = this.operandA.viewData() + this.operandB.viewData();
          
        otherwise
          res = 1;
      end
    end
    
  end
  
  methods(Static)
    
  end
  
end
