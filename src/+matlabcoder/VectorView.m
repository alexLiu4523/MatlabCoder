classdef VectorView < matlabcoder.ViewBase
  %VECTORVIEW
  
  methods
    
    function this = VectorView(vectorHandle, index)
      this = this@matlabcoder.ViewBase(vectorHandle, {index});
    end
    
    function res = viewData(this)
      if matlabcoder.IndexBase.isLogicalIndex(this.indexes{1})
        % generates a new matrix according to the function
        res = this.indexes{1}.logicalFunc(this.dataHandle.data);
      else
        res = this.dataHandle.data(this.indexes{1}.toMatlabIndex());
      end
    end
    
    function res = subview(this, subIndex)
      index = this.indexes{1};
      if matlabcoder.IndexBase.isLogicalIndex(index) && matlabcoder.IndexBase.isLogicalIndex(subIndex)
        % generates a new logical matrix
        newLogicalIndex = matlabcoder.LogicalIndex(@(x) index.logicalFunc(x) && subIndex.logicalFunc(x));
        res = matlabcoder.VectorView(this.matrixHandle.data, newLogicalIndex);
        
      else
        if matlabcoder.IndexBase.isVectorableIndex(index) && matlabcoder.IndexBase.isVectorableIndex(subIndex)
          res = matlabcoder.VectorView(this.dataHandle, index.compose(subIndex));
        else
          matlabcoder.Util.throwException('VectorView:viewData:IllegalArgument', 'Illegal argument.');
        end
        
      end
      
    end
    
    function res = eqImpl(this, other)
      res = matlabcoder.VectorView.isVectorView(other) && ...
        this.dataHandle.eqImpl(other.dataHandle) && this.indexes{1} == other.indexes{1};
    end
    
    % this = this op operand => this.operateSelfImpl(op, operand)
    function res = operateSelfImpl(this, operation, operand)
      switch(operation)
        case matlabcoder.MatrixOpertationEnum.PlusScalar
          
        case matlabcoder.MatrixOpertationEnum.PlusMatrix
          view = this.viewData();
          view.assignImpl(view + operand);
          res = view;
          
        otherwise
          matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
      end
    end
    
    % this = other => this.assignImpl(other)
    function res = assignImpl(this, other)
      if matlabcoder.OperationValue.isOperationValue(other)
        switch(other.operation)
          case matlabcoder.VectorOperationEnum.PlusVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) + other.operandB(view)
              visplstub.Stub_Vsip_VAdd(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.PlusScalar
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) + other.operandB(Scalar)
              visplstub.Stub_Vsip_SVAdd(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CPlusVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) + other.operandB(view)
              visplstub.Stub_Vsip_CVAdd(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CPlusScalar
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) + other.operandB(Scalar)
              visplstub.Stub_Vsip_CSVAdd(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CPlusRScalar
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) + other.operandB(Scalar)
              visplstub.Stub_Vsip_RSCVAdd(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.TimesVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) .* other.operandB(view)
              visplstub.Stub_Vsip_VMul(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CTimesVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) .* other.operandB(view)
              visplstub.Stub_Vsip_CVMul(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.TimesCVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) .* other.operandB(view)
              visplstub.Stub_Vsip_RCVMul(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.TimesScalar
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) .* other.operandB(Scalar)
              visplstub.Stub_Vsip_SVMul(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CTimesScalar
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) .* other.operandB(Scalar)
              visplstub.Stub_Vsip_CSVMul(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
            
            
            
          case matlabcoder.VectorOperationEnum.MinusVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) - other.operandB(view)
              visplstub.Stub_Vsip_VSub(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.MinusCVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) - other.operandB(view)
              visplstub.Stub_Vsip_RCVSub(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CMinusRVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) - other.operandB(view)
              visplstub.Stub_Vsip_CRVSub(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CMinusVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) - other.operandB(view)
              visplstub.Stub_Vsip_CVSub(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.RightDivideVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) ./ other.operandB(view)
              visplstub.Stub_Vsip_VRDiv(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.RightDivideScalar
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) ./ other.operandB(Scalar)
              visplstub.Stub_Vsip_VSRDiv(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CRightDivideVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) ./ other.operandB(view)
              visplstub.Stub_Vsip_CVRDiv(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CRightDivideRVector
            if matlabcoder.VectorView.isVectorView(other.operandA)&&matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) ./ other.operandB(view)
              visplstub.Stub_Vsip_CRVRDiv(other.operandA,other.operandB,this);
              
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.LessThanVector
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) < other.operandB(view)
              visplstub.Stub_Vsip_VLt(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.LessThanScalar
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) < other.operandB(scalar) aka other.operandB(scalar) > other.operandA(view)
              visplstub.Stub_Vsip_SVGt(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.GreaterThanVector
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) > other.operandB(view)
              visplstub.Stub_Vsip_VGt(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.GreaterThanScalar
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) > other.operandB(scalar) aka other.operandB(scalar) < other.operandA(view)
              visplstub.Stub_Vsip_SVLt(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.LessEqualVector
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) <= other.operandB(view)
              visplstub.Stub_Vsip_VLEq(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.LessEqualScalar
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) <= other.operandB(scalar) aka other.operandB(scalar) >= other.operandA(view)
              visplstub.Stub_Vsip_SVGe(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.GreaterEqualVector
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) >= other.operandB(view)
              visplstub.Stub_Vsip_VGe(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.GreaterEqualScalar
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) >= other.operandB(scalar) aka other.operandB(scalar) <= other.operandA(view)
              visplstub.Stub_Vsip_SVLe(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.NotEqualVector
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) ~= other.operandB(view)
              visplstub.Stub_Vsip_VNe(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.NotEqualScalar
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) ~= other.operandB(scalar)
              visplstub.Stub_Vsip_SVNe(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.EqualToVector
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) == other.operandB(view)
              visplstub.Stub_Vsip_VEq(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CEqualToVector
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) == other.operandB(view)
              visplstub.Stub_Vsip_CVEq(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.EqualToScalar
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) == other.operandB(scalar)
              visplstub.Stub_Vsip_SVEq(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CEqualToScalar
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) == other.operandB(scalar)
              visplstub.Stub_Vsip_CSVEq(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.LogicalAnd
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) & other.operandB(view)
              visplstub.Stub_Vsip_VAnd(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.LogicalOr
            if matlabcoder.VectorView.isVectorView(other.operandA) && matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) | other.operandB(view)
              visplstub.Stub_Vsip_VOr(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.UnaryPlus
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = +other.operandA(view)
              %visplstub.Stub_Vsip_VOr(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.LogicalNot
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = ~other.operandA(view)
              visplstub.Stub_Vsip_VNot(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.UnaryMinus
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = -other.operandA(view)
              visplstub.Stub_Vsip_VNeg(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CTranspose
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = -other.operandA(view)
              visplstub.Stub_Vsip_CMHerm(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.Transpose
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = -other.operandA(view)
              visplstub.Stub_Vsip_MTrans(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.Cos
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = cos(other.operandA)(view)
              visplstub.Stub_Vsip_VCos(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.ExpR
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = exp(other.operandA)(view)
              visplstub.Stub_Vsip_VExpR(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.ExpC
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = exp(other.operandA)(view)
              visplstub.Stub_Vsip_VExpC(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.Exp10
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = 10^(other.operandA)(view)
              visplstub.Stub_Vsip_VExp10(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.Log
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = log(other.operandA)(view)
              visplstub.Stub_Vsip_VLog10(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.Sin
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = sin(other.operandA)(view)
              visplstub.Stub_Vsip_VSin(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.SqrtR
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = sqrt(other.operandA)(view)
              visplstub.Stub_Vsip_VSqrtR(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.SqrtC
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = sqrt(other.operandA)(view)
              visplstub.Stub_Vsip_VSqrtC(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.Conj
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = conj(other.operandA)(view)
              visplstub.Stub_Vsip_VConj(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CumsumR
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = cumsum(other.operandA)(view)
              visplstub.Stub_Vsip_VCumsumR(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.CumsumC
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = cumsum(other.operandA)(view)
              visplstub.Stub_Vsip_VCumsumC(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.AbsR
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = abs(other.operandA)(view)
              visplstub.Stub_Vsip_VMagR(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.AbsC
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = abs(other.operandA)(view)
              visplstub.Stub_Vsip_VMagC(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.MeanR
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = mean(other.operandA)(view)
              visplstub.Stub_Vsip_VMeanR(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.MeanC
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = mean(other.operandA)(view)
              visplstub.Stub_Vsip_VMeanC(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.Sq2
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = (other.operandA).^2 (view)
              visplstub.Stub_Vsip_VSq2(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.Imag
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = imag(other.operandA) (view)
              visplstub.Stub_Vsip_VImagView(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.VectorOperationEnum.Real
            if matlabcoder.VectorView.isVectorView(other.operandA)
              % this(view) = real(other.operandA) (view)
              visplstub.Stub_Vsip_VRealView(other.operandA,this);
            else
              matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          otherwise
            matlabcoder.Util.throwException('VectorView:assignImpl:IllegalArgument', 'Illegal argument.');  
        end
        
      elseif matlabcoder.VectorView.isVectorView(other)
        
      elseif matlabcoder.VectorHandle.isVectorHandle(other)
        
      elseif numel(other) > 1&&isvector(other)
        %xIndex = this.indexes{1};
        %yIndex = this.indexes{2};
        % other is a builtin numeric vector
        this.dataHandle.data(this.matlabIndexes{:}) = other;
        
      else
        matlabcoder.Util.throwException('VectorView:assign:IllegalArgument', 'Illegal argument.');
      end
      
      res = this;
    end
    
    % https://www.mathworks.com/help/matlab/ref/plus.html
    function res = plus(this, B)
      coder.inline('never');
      if isreal(this)&&isreal(B)
        if matlabcoder.VectorView.isVectorView(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.PlusVector,B);
        elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.PlusScalar,B);
        else
          matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
        end
      elseif ~isreal(this)
        if matlabcoder.VectorView.isVectorView(B)&&~isreal(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.CPlusVector,B);
        elseif matlabcoder.Util.isNumericScalar(B)&&~isreal(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.CPlusScalar,B);
        elseif matlabcoder.Util.isNumericScalar(B)&&~isreal(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.CPlusRScalar,B);
        else
          matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
        end
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = times(this, B)
      coder.inline('never');
      if isreal(this)
        if isreal(B)&&matlabcoder.VectorView.isVectorView(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.TimesVector,B);
        elseif ~isreal(B)&&matlabcoder.VectorView.isVectorView(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.TimesCVector,B);
        elseif isreal(B)&&matlabcoder.Util.isNumericScalar(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.TimesScalar,B);
        else
          matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
        end
      else
        if ~isreal(B)&&matlabcoder.VectorView.isVectorView(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.CTimesVector,B);
        elseif ~isreal(B)&&matlabcoder.Util.isNumericScalar(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.CTimesScalar,B);
        else
          matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
        end
      end
    end
    
    function res = mtimes(this,B)
      coder.inline('never');
      if isreal(this)&&isreal(B)
        res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.VectorTimes,B);
      elseif ~isreal(this)&&~isreal(B)
        res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.CVectorTimes,B);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = minus(this, B)
      coder.inline('never');
      if isreal(this)
        if matlabcoder.VectorView.isVectorView(B)&&isreal(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.MinusVector,B);
        elseif matlabcoder.VectorView.isVectorView(B)&&~isreal(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.MinusCVector,B);
        else
          matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
        end
      else
        if matlabcoder.VectorView.isVectorView(B)&&isreal(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.CMinusRVector,B);
        elseif matlabcoder.VectorView.isVectorView(B)&&~isreal(B)
          res = matlabcoder.OperationValue.of(this,matlabcoder.VectorOperationEnum.CMinusVector,B);
        else
          matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
        end
      end
    end
    
    function res = rdivide(this, B)
      coder.inline('never');
      if isreal(this)&&isreal(B)
        if matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.RightDivideScalar, B);
        elseif matlabcoder.VectorView.isVectorView(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.RightDivideVector, B);
        else
          matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
        end
      elseif ~isreal(this)
        if ~isreal(B)&&matlabcoder.VectorView.isVectorView(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.CRightDivideVector, B);
        elseif isreal(B)&&matlabcoder.VectorView.isVectorView(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.CRightDivideRVector, B);
        else
          matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
        end
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = ldivide(this, B)
      coder.inline('never');
      if matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.LeftDivideScalar, B);
      elseif matlabcoder.VectorView.isVectorView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.LeftDivideVector, B);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = lt(this, B)
      coder.inline('never');
      if matlabcoder.VectorView.isVectorView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.LessThanVector, B);
      elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.LessThanScalar, B);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = gt(this, B)
      coder.inline('never');
      if matlabcoder.VectorView.isVectorView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.GreaterThanVector, B);
      elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.GreaterThanScalar, B);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = le(this, B)
      coder.inline('never');
      if matlabcoder.VectorView.isVectorView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.LessEqualVector, B);
      elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.LessEqualScalar, B);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = ge(this, B)
      coder.inline('never');
      if matlabcoder.VectorView.isVectorView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.GreaterEqualVector, B);
      elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.GreaterEqualScalar, B);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = ne(this, B)
      coder.inline('never');
      if matlabcoder.VectorView.isVectorView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.NotEqualVector, B);
      elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.NotEqualScalar, B);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = eq(this, B)
      coder.inline('never');
      if isreal(this)&&isreal(B)
        if matlabcoder.VectorView.isVectorView(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.EqualToVector, B);
        elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.EqualToScalar, B);
        else
          matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
        end
      elseif ~isreal(this)&&~isreal(B)
        if matlabcoder.VectorView.isVectorView(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.CEqualToVector, B);
        elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.CEqualToScalar, B);
        else
          matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
        end
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = and(this, B)
      coder.inline('never');
      if matlabcoder.VectorView.isVectorView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.LogicalAnd, B);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = or(this, B)
      coder.inline('never');
      if matlabcoder.VectorView.isVectorView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.LogicalOr, B);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = uplus(this)
      coder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.UnaryPlus);
    end
    
    function res = uminus(this)
      coder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.UnaryMinus);
    end
    
    function res = not(this)
      coder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.LogicalNot);
    end
    
    function res = ctranspose(this)
      coder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.CTranspose);
    end
    
    function res = transpose(this)
      coder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Transpose);
    end
    
    
    function res = cos(this)
      coder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Cos);
    end
    
    function res = exp(this)
      coder.inline('never');
      if isreal(this)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.ExpR);
      else
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.ExpC);
      end
    end
    
    function res = log(this)
      oder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Log);
    end
    
    function res = sin(this)
      coder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Sin);
    end
    
    function res = sqrt(this)
      coder.inline('never');
      if isreal(this)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.SqrtR);
      else
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.SqrtC);
      end
    end
    
    function res = conj(this)
      coder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Conj);
    end
    
    function res = cumsum(this)
      coder.inline('never');
      if isreal(this)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.CumsumR);
      else
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.CumsumC);
      end
    end
    
    function res = abs(this)
      coder.inline('never');
      if isreal(this)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.AbsR);
      else
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.AbsC);
      end
    end
    
    function res = mean(this)
      coder.inline('never');
      if isreal(this)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.MeanR);
      else
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.MeanC);
      end
    end
    
    function res = sum(this)
      coder.inline('never');
      if isreal(this)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.SumR);
      else
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.SumC);
      end
    end
    
    function res = imag(this)
      coder.inline('never');
      if ~isreal(this)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Imag);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = real(this)
      coder.inline('never');
      if ~isreal(this)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Real);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = max(this,B)
      coder.inline('never');
      if matlabcoder.VectorView.isVectorView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Max, B);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = min(this)
      coder.inline('never');
      if nargin == 1
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Min);
      elseif nargin == 2
        res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Min2);
      else
        matlabcoder.Util.throwException('VectorView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    %functions with special args map to vsipl functions
    function res = exp10(this)
      coder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Exp10);
    end
    
    function res = sq2(this)
      coder.inline('never');
      res = matlabcoder.OperationValue.of(this, matlabcoder.VectorOperationEnum.Sq2);
    end
    
    function res = maxabs(this)
      coder.inline('never');
      if isreal(this)
        res = matlabcoder.OperationValue.of(this,matlabcoder.VectorView.MaxAbsR);
      else
        res = matlabcoder.OperationValue.of(this,matlabcoder.VectorView.MaxAbsC);
      end
    end
    
    function res = minabs(this)
      coder.inline('never');
      if isreal(this)
        res = matlabcoder.OperationValue.of(this,matlabcoder.VectorView.MinAbsR);
      else
        res = matlabcoder.OperationValue.of(this,matlabcoder.VectorView.MinAbsC);
      end
    end
    
  end
  
  methods(Static)
    
    function res = isVectorView(obj)
      res = isa(obj, 'matlabcoder.VectorView');
    end
    
  end
  
end
