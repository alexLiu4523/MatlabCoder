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
   
  end
  
  methods(Static)
    
    function res = isOperationValue(obj)
      res = isa(obj, 'matlabcoder.OperationValue');
    end
    
  end

end

