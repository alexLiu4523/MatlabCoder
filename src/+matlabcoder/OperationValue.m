classdef OperationValue
  %OperationValue
  
  methods
    
%     function res = compute(this)
%       % Note: Without `coder.inline('never')`, a wrong case maybe inlined into the code.
%       coder.inline('never');
%       % perform operation according to operandA's type and then the operation
%       if matlabcoder.MatrixView.isMatrixView(this.operandA)
%         switch(this.operation)
%           case matlabcoder.MatrixOperationEnum.PlusScalar
%             res = this.operandA.viewData() + this.operandB;
%           case matlabcoder.MatrixOperationEnum.PlusMatrix
%             res = this.operandA.viewData() + this.operandB.viewData();
%             
%           otherwise
%             res = 1;
%         end
%         
%       elseif matlabcoder.VectorView.isVectorView(this.operandA)
%         % TODO
%         res = 1;
%         
%       elseif matlabcoder.Matrix3DView.isMatrix3DView(this.operandA)
%         % TODO
%         res = 1;
%         
%       elseif isscalar(this.operandA)
%         res = 1;
%         
%       else
%         matlabcoder.Util.throwException('OperationValue:compute:UnsupportedOperation', '');
%       end
%       
%     end
  
  end


  methods(Static)
    
    function res = isOperationValue(obj)
      res = isa(obj, 'matlabcoder.OperationValue');
    end
    
    function res = of(operandA, operation, operandB)
      if matlabcoder.MatrixView.isMatrixView(operandA)
        if matlabcoder.MatrixView.isMatrixView(operandB)
          res = matlabcoder.OperationValueForMatrixMatrix(operandA, operation, operandB);
        elseif isscalar(operandB)
          res = matlabcoder.OperationValueForMatrixScalar(operandA, operation, operandB);
        else
          matlabcoder.Util.throwException('OperationValue:of:UnsupportedOperation', '');
        end
        
      else
         matlabcoder.Util.throwException('OperationValue:of:UnsupportedOperation', '');
      end
    end
    
  end
  
end
