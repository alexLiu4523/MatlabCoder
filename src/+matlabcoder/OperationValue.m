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
      
      %根据操作数情况指定具体的实现类，如果想要允许嵌套，必须改动此处
      
      if matlabcoder.MatrixView.isMatrixView(operandA)
        if nargin == 2       
          res = matlabcoder.OperationValueForMatrixUnary(operandA, operation);
        elseif matlabcoder.MatrixView.isMatrixView(operandB)
          res = matlabcoder.OperationValueForMatrixMatrix(operandA, operation, operandB);
        elseif isscalar(operandB)
          res = matlabcoder.OperationValueForMatrixScalar(operandA, operation, operandB);
        else
          matlabcoder.Util.throwException('OperationValue:of:UnsupportedOperation', '');
        end

      elseif matlabcoder.VectorView.isVectorView(operandA)
        if nargin == 2       
          res = matlabcoder.OperationValueForVectorUnary(operandA, operation);
        elseif matlabcoder.VectorView.isVectorView(operandB)
          res = matlabcoder.OperationValueForVectorVector(operandA, operation, operandB);
        elseif isscalar(operandB)
          res = matlabcoder.OperationValueForVectorScalar(operandA, operation, operandB);
        else
          matlabcoder.Util.throwException('OperationValue:of:UnsupportedOperation', '');
        end  

      else
         matlabcoder.Util.throwException('OperationValue:of:UnsupportedOperation', '');
      end
    end
    
  end
  
end
