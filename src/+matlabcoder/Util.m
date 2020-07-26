classdef Util
  
  methods(Static)
    
    function res = getOperandData(operand)
      if matlabcoder.ViewBase.isView(operand)
        res = operand.viewData();
      elseif matlabcoder.HandleBase.isHandle(operand)
        res = operand.data;
      elseif matlabcoder.OperationValue.isOperationValue(operand)
        % TODO
        res = 0;
      else
        res = operand;
      end
    end
    
    function throwException(idetifier, varargin)
      % Note: Matlab coder do not support try/catch
      % throw(MException('SinglePositionIndex:compose:IllegalArgument', varargin{:}));
      matlabstub.Stub_Util_throwException(idetifier, varargin{:});
    end
    
  end
  
end

