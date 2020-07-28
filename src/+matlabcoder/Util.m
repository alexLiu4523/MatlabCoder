classdef Util
  
  methods(Static)
    
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

