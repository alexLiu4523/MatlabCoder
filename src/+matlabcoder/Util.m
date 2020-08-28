classdef Util
  
  methods(Static)
    
    function res = isNumericScalar(operand)
      res = isnumeric(operand) && isscalar(operand);
    end
    
    function res = isNumericArray(operand)
      res = isnumeric(operand) && numel(operand) > 1;
    end
    
    function res = isNumericMatrixOfDim(operand, dim)
      res = isnumeric(operand) && numel(operand) == dim;
    end
    
    function res = isNumericMatrix(operand)
      res = matlabcoder.Util.isNumericMatrixOfDim(operand, 2);
    end
    
    function res = getOperandData(operand)
      if matlabcoder.ViewBase.isView(operand)
        res = operand.viewData();
      elseif matlabcoder.HandleBase.isHandle(operand)
        res = operand.data;
      elseif matlabcoder.OperationValue.isOperationValue(operand)
        res = operand.compute();
      else
        res = operand;
      end
    end
    
    function res = throwException(idetifier, varargin)
      % Note: Matlab coder do not support try/catch
      % throw(MException('SinglePositionIndex:compose:IllegalArgument', varargin{:}));
      res = matlabstub.Stub_Util_throwException(idetifier, varargin{:});
    end
    
  end
  
end

