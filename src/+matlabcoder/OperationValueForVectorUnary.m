classdef OperationValueForVectorUnary < matlabcoder.OperationValue
  %OperationValueForVectorVector
  
  properties
    operandA
    operation
  end
  
  methods
    
    function this = OperationValueForVectorUnary(operandA, operation)
      this.operandA = operandA;
      this.operation = operation;
    end
    
    function res = compute(this)
      coder.inline('never');
      
      switch(this.operation)
        case matlabcoder.VectorOperationEnum.PlusVector
          res = this.operandA.viewData();
          
        otherwise
          res = 1;
      end
    end
    
  end
  
  methods(Static)
    
  end
  
end
