classdef MatrixView < matlabcoder.ViewBase
  %MATRIXVIEW
  
  methods
    
    function this = MatrixView(matrixHandle, varargin)
      this = this@matlabcoder.ViewBase(matrixHandle, varargin);
    end
    
    function res = viewData(this)
      if numel(this.indexes) == 1 && matlabcoder.IndexBase.isLogicalIndex(this.indexes{1})
        % generate a new matrix according to the function
        res = this.indexes{1}.logicalFunc(this.dataHandle.data);
      else
        % Note: `cellfun` is not supported in MATLAB coder.
        % realIndexes = cellfun(@(v) v.toVector(), this.indexes, 'UniformOutput', false);
        % res = this.dataHandle.data(realIndexes{:});
        if numel(this.indexes) == 1
          res = this.dataHandle.data(this.indexes{1}.toMatlabIndex());
        elseif numel(this.indexes) == 2
          res = this.dataHandle.data(this.indexes{1}.toMatlabIndex(), this.indexes{2}.toMatlabIndex());
        else
          % throw(MException('MatrixView:viewData:IllegalState', 'Illegal indexes.'));
          matlabcoder.Util.throwException('MatrixView:viewData:IllegalState', 'Illegal indexes.');
        end
      end
      
      %       if numel(this.indexes) == 1
      %         logicalIndex = this.indexes{1};
      %         if isa(this.indexes, 'matlabcoder.LogicalIndex')
      %           % generates a new matrix according to the function
      %           res = logicalIndex.logicalFunc(this.matrixHandle.data);
      %         else
      %           throw(MException('MatrixView:viewData:IllegalArgument', 'Illegal argument.'));
      %         end
      %       elseif numel(this.indexes) == 2
      %         xIndex = this.indexes{1};
      %         yIndex = this.indexes{2};
      %         if matlabcoder.IndexBase.isVectorableIndex(xIndex) && matlabcoder.IndexBase.isVectorableIndex(yIndex)
      %           res = this.dataHandle.data(xIndex.toVector, yIndex.toVector);
      %         else
      %           throw(MException('MatrixView:viewData:IllegalArgument', 'Illegal argument.'));
      %         end
      %       else
      %         throw(MException('MatrixView:viewData:IllegalArgument', 'Illegal argument.'));
      %       end
    end
    
    function res = matlabIndexes(this)
      res = {this.indexes{1}.toMatlabIndex(), this.indexes{2}.toMatlabIndex()};
    end
    
    function res = subview(this, varargin)
      if numel(this.indexes) == 1 && numel(varargin) == 1 ...
          && matlabcoder.IndexBase.isLogicalIndex(this.indexes{1}) && matlabcoder.IndexBase.isLogicalIndex(varargin{1})
        logicalIndex = this.indexes{1};
        otherLogicIndex = varargin{1};
        % generate a new logical matrix
        newLogicalIndex = matlabcoder.LogicalIndex(@(x) logicalIndex.logicalFunc(x) && otherLogicIndex.logicalFunc(x));
        res = matlabcoder.MatrixView(this.matrixHandle.data, newLogicalIndex);
        
      elseif numel(this.indexes) == 1 && numel(varargin) == 1
        xIndex = this.indexes{1};
        subXIndex = varargin{1};
        if xIndex.isComposeable() && subXIndex.isComposeable()
          res = matlabcoder.MatrixView(this.matrixHandle, xIndex.compose(subXIndex));
        else
          matlabcoder.Util.throwException('MatrixView:subview:IllegalArgument', 'Illegal argument.');
        end
        
      elseif numel(this.indexes) == 2 && numel(varargin) == 2
        xIndex = this.indexes{1};
        yIndex = this.indexes{2};
        subXIndex = varargin{1};
        subYIndex = varargin{2};
        if xIndex.isComposeable() && subXIndex.isComposeable() ...
            && subXIndex.isComposeable() && subYIndex.isComposeable()
          res = matlabcoder.MatrixView(this.dataHandle, xIndex.compose(subXIndex), yIndex.compose(subYIndex));
        else
          matlabcoder.Util.throwException('MatrixView:viewData:IllegalArgument', 'Illegal argument.');
        end
        
      else
        matlabcoder.Util.throwException('MatrixView:viewData:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = eqImpl(this, other)
      if isa(other, 'matlabcoder.MatrixView')
        if this.indexCount == 1 && other.indexCount == 1
          res = this.dataHandle.eqImpl(other.dataHandle) && (this.indexes{1} == other.indexes{1});
        elseif this.indexCount == 2 && other.indexCount == 2
          res = this.dataHandle.eqImpl(other.dataHandle) && (this.indexes{1} == other.indexes{1}) && (this.indexes{2} == other.indexes{2});
        else
          res = false;
        end
      else
        res = false;
      end
    end
    
    % this = other => this.assignImpl(other)
    function res = assignImpl(this, other)
      
      if matlabcoder.OperationValue.isOperationValue(other)
        switch(other.operation)
          case matlabcoder.MatrixOperationEnum.PlusScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) + other.operandB(scalar) =>
              visplstub.Stub_Vsip_SMAdd(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.MatrixOperationEnum.PlusMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) + other.operandB(view)
              visplstub.Stub_Vsip_MAdd(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.Times
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) * other.operandB(view)
              visplstub.Stub_Vsip_SMMul_Double(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            % Add other cases
          
          case matlabcoder.MatrixOperationEnum.MinusScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) - other.operandB(scalar) =>
              visplstub.Stub_Vsip_SMSub(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
            
          case matlabcoder.MatrixOperationEnum.MinusMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) - other.operandB(view)
              visplstub.Stub_Vsip_MSub(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
         
          case matlabcoder.MatrixOperationEnum.RightDivideScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) ./ other.operandB(scalar)
              visplstub.Stub_Vsip_MSRDiv(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.RightDivideMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) ./ other.operandB(view)
              visplstub.Stub_Vsip_MRDiv(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.LeftDivideScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) .\ other.operandB(scalar)
              visplstub.Stub_Vsip_SMRDiv(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.LeftDivideMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) .\ other.operandB(view)
              visplstub.Stub_Vsip_MRDiv(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
          
          case matlabcoder.MatrixOperationEnum.MatrixTimesMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) * other.operandB(view)
              visplstub.Stub_Vsip_MProd(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.MatrixTimesVector
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.VectorView.isVectorView(other.operandB)
              % this(view) = other.operandA(view) * other.operandB(view)
              visplstub.Stub_Vsip_MVProd(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.LessThanMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) < other.operandB(view)
              visplstub.Stub_Vsip_MLt(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.LessThanScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) < other.operandB(scalar) aka other.operandB(scalar) > other.operandA(view)
              visplstub.Stub_Vsip_SMGt(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.GreaterThanMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) > other.operandB(view)
              visplstub.Stub_Vsip_MGt(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.GreaterThanScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) > other.operandB(scalar) aka other.operandB(scalar) < other.operandA(view)
              visplstub.Stub_Vsip_SMLt(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.LessEqualMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) <= other.operandB(view)
              visplstub.Stub_Vsip_MLEq(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.LessEqualScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) <= other.operandB(scalar) aka other.operandB(scalar) >= other.operandA(view)
              visplstub.Stub_Vsip_SMGe(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.GreaterEqualMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) >= other.operandB(view)
              visplstub.Stub_Vsip_MGe(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.GreaterEqualScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) >= other.operandB(scalar) aka other.operandB(scalar) <= other.operandA(view)
              visplstub.Stub_Vsip_SMLe(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.NotEqualMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) ~= other.operandB(view)
              visplstub.Stub_Vsip_MNe(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.NotEqualScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) ~= other.operandB(scalar)
              visplstub.Stub_Vsip_SMNe(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.EqualToMatrix
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) == other.operandB(view)
              visplstub.Stub_Vsip_MEq(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.EqualToScalar
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = other.operandA(view) == other.operandB(scalar)
              visplstub.Stub_Vsip_SMEq(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.LogicalAnd
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) & other.operandB(view)
              visplstub.Stub_Vsip_MAnd(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.LogicalOr
            if matlabcoder.MatrixView.isMatrixView(other.operandA) && matlabcoder.MatrixView.isMatrixView(other.operandB)
              % this(view) = other.operandA(view) | other.operandB(view)
              visplstub.Stub_Vsip_MOr(other.operandA, other.operandB, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
          
          case matlabcoder.MatrixOperationEnum.UnaryPlus
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = +other.operandA(view)
              visplstub.Stub_Vsip_MOr(other.operandB, other.operandA, this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.LogicalNot
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = ~other.operandA(view)
              visplstub.Stub_Vsip_MNot(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.UnaryMinus
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = -other.operandA(view)
              visplstub.Stub_Vsip_MNeg(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.CTranspose
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = -other.operandA(view)
              visplstub.Stub_Vsip_CMHerm(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.Transpose
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = -other.operandA(view)
              visplstub.Stub_Vsip_MTrans(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end
          
          case matlabcoder.MatrixOperationEnum.Max
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = -other.operandA(view)
              visplstub.Stub_Vsip_MTrans(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end  
          

          case matlabcoder.MatrixOperationEnum.Cos
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = cos(other.operandA(view))
              visplstub.Stub_Vsip_MCos(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end  

          case matlabcoder.MatrixOperationEnum.Log
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = log(other.operandA(view))
              visplstub.Stub_Vsip_MLog10(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.Sin
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = log(other.operandA(view))
              visplstub.Stub_Vsip_MSin(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.SqrtR
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = sqrt(other.operandA(view))
              visplstub.Stub_Vsip_MSqrtR(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.SqrtC
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = sqrt(other.operandA(view))
              visplstub.Stub_Vsip_MSqrtC(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.Abs
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = abs(other.operandA(view))
              visplstub.Stub_Vsip_CMMag(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.MMean
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = log(other.operandA(view))
              visplstub.Stub_Vsip_MMean(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.CMMean
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = log(other.operandA(view))
              visplstub.Stub_Vsip_CMMean(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.Conj
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = conj(other.operandA(view))
              visplstub.Stub_Vsip_CMConj(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.MCumsum
            if matlabcoder.MatrixView.isMatrixView(other.operandA)&&matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = cumsum(other.operandA(view))
              visplstub.Stub_Vsip_MCumsum(other.operandA,other.operandB,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.CMCumsum
            if matlabcoder.MatrixView.isMatrixView(other.operandA)&&matlabcoder.Util.isNumericScalar(other.operandB)
              % this(view) = cumsum(other.operandA(view))
              visplstub.Stub_Vsip_CMCumsum(other.operandA,other.operandB,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.Exp10
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = 10^(other.operandA(view))
              visplstub.Stub_Vsip_MExp10(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.Sq2
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = (other.operandA(view)).^2
              visplstub.Stub_Vsip_MSq(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          case matlabcoder.MatrixOperationEnum.Sumval
            if matlabcoder.MatrixView.isMatrixView(other.operandA)
              % this(view) = sum(other.operandA(view)(:))
              visplstub.Stub_Vsip_MSumval(other.operandA,this);
            else
              matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
            end

          otherwise
            matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
        end
        
      elseif matlabcoder.MatrixView.isMatrixView(other)
        this.dataHandle.data(this.matlabIndexes{:}) = other.viewData();
        
      elseif matlabcoder.MatrixHandle.isMartixHandle(other)
        this.dataHandle.data(this.matlabIndexes{:}) = other.data;
        
      elseif isnumeric(other) && numel(other) > 1
        % other is a builtin numeric matrix
        this.dataHandle.data(this.matlabIndexes{:}) = other;
        
      else
        matlabcoder.Util.throwException('MatrixView:assign:IllegalArgument', 'Illegal argument.');
      end
      
      res = this;
      
    end
  
    % This function is depreacted.
    % this = this op operand => this.operateSelfImpl(op, operand)
    function res = operateSelfImpl(this, operation, operand)
      switch(operation)
        case matlabcoder.MatrixOperationEnum.PlusScalar
          
        case matlabcoder.MatrixOperationEnum.PlusMatrix
          if matlabcoder.MatrixView.isMatrixView(operand) && matlabcoder.MatrixView.isMatrixView(operand)
            % this(view) = this(view) + operand(view)
            visplstub.Stub_Vsip_MAdd(this, operand, this);
          else
            matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
          end
          
        case matlabcoder.MatrixOperationEnum.Times
          % this(view) = other.operandA(view) .* other.operandB(scalar)
          % TODO
          visplstub.Stub_Vsip_SMMul_Double(operand, this, this);
          
        otherwise
          matlabcoder.Util.throwException('MatrixView:assignImpl:IllegalArgument', 'Illegal argument.');
      end
      
      res = this;
    end
    
    %region Operators 
    
    % https://www.mathworks.com/help/matlab/ref/plus.html
    function res = plus(this, B)
      coder.inline('never');
      if matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.PlusScalar, B);
      elseif matlabcoder.MatrixView.isMatrixView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.PlusMatrix, B);
      else
        matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    % Element-wise multiplication, A .* b
    function res = times(this, b)
      coder.inline('never');
      if ~isscalar(b)
        matlabcoder.Util.throwException('MatrixView:times:IllegalArgument', 'b should be scalar.');
      end
      
      if isfloat(b)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Times, b);
        
      else
        res = matlabcoder.ViewBase.throwForUnsupportOperation();
      end
      
    end
    

    function res = minus(this, B)
      coder.inline('never');
      if matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.MinusScalar, B);
      elseif matlabcoder.MatrixView.isMatrixView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.MinusMatrix, B);
      else
        matlabcoder.Util.throwException('MatrixView:minus:IllegalArgument', 'Illegal argument.');
      end
    end
    
    function res = rdivide(this, B)
      coder.inline('never');
      if matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.RightDivideScalar, B);
      elseif matlabcoder.MatrixView.isMatrixView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.RightDivideMatrix, B);
      else
        matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
      end
    end

    function res = ldivide(this, B)
      coder.inline('never');
      if matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.LeftDivideScalar, B);
      elseif matlabcoder.MatrixView.isMatrixView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.LeftDivideMatrix, B);
      else
        matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
      end
    end
    

    function res = mtimes(this, B)
      coder.inline('never');
      if matlabcoder.VectorView.isVectorView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.MatrixTimesVector, B);
      elseif matlabcoder.MatrixView.isMatrixView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.MatrixTimesMatrix, B);
      else
        matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
      end
    end

    
    function res = lt(this, B)
      coder.inline('never');
      if matlabcoder.MatrixView.isMatrixView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.LessThanMatrix, B);
      elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.LessThanScalar, B);
      else
        matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
      end
    end

    function res = gt(this, B)
      coder.inline('never');
      if matlabcoder.MatrixView.isMatrixView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.GreaterThanMatrix, B);
      elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.GreaterThanScalar, B);
      else
        matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
      end
    end

    function res = le(this, B)
      coder.inline('never');
      if matlabcoder.MatrixView.isMatrixView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.LessEqualMatrix, B);
      elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.LessEqualScalar, B);
      else
        matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
      end
    end

    function res = ge(this, B)
      coder.inline('never');
      if matlabcoder.MatrixView.isMatrixView(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.GreaterEqualMatrix, B);
      elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.GreaterEqualScalar, B);
      else
        matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
      end
    end

    
      function res = ne(this, B)
        coder.inline('never');
        if matlabcoder.MatrixView.isMatrixView(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.NotEqualMatrix, B);
        elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.NotEqualScalar, B);
        else
          matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
        end
      end

      function res = eq(this, B)
        coder.inline('never');
        if matlabcoder.MatrixView.isMatrixView(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.EqualToMatrix, B);
        elseif matlabcoder.Util.isNumericScalar(B) % isscalar(B) && isnumeric(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.EqualToScalar, B);
        else
          matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
        end
      end

      function res = and(this, B)
        coder.inline('never');
        if matlabcoder.MatrixView.isMatrixView(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.LogicalAnd, B);
        else
          matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
        end
      end

      function res = or(this, B)
        ocder.inline('never');
        if matlabcoder.MatrixView.isMatrixView(B)
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.LogicalOr, B);
        else
          matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
        end
      end
    
      function res = uplus(this)
        coder.inline('never');
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.UnaryPlus);
      end

      function res = uminus(this)
        coder.inline('never');
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.UnaryMinus);
      end

      function res = not(this)
        coder.inline('never');
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.LogicalNot);
      end

      function res = ctranspose(this)
        coder.inline('never');
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.CTranspose);
      end

      function res = transpose(this)
        coder.inline('never');
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Transpose);
      end
    
      function res = min(this)
        res = -1;
      end
    
      function res = max(this)
        %coder.inline('never');
        %res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Max);
        res = 1;
      end


    %E

      function res = cos(this)
        coder.inline('never');
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Cos);
      end

      function res = log(this)
        coder.inline('never');
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Log);
      end

      function res = sin(this)
        coder.inline('never');
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Sin);
      end

      function res = sqrt(this)
        coder.inline('never');
        if isreal(this)
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.SqrtR);
        else
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.SqrtC);
        end
      end

      function res = abs(this)
        coder.inline('never');
        if ~isreal(this)
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Abs);
        else
          matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
        end
      end

      function res = mean(this)
        coder.inline('never');
        if isreal(this)
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.MMean);
        else
          res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.CMMean);
        end
      end

      function res = conj(this)
        coder.inline('never');
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Conj);
      end

      function res = cumsum(this,B) 
        coder.inline('never');
        if isreal(this)
          if nargin==1||B==1
            res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.MCumsum,1);
          elseif B == 2
            res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.MCumsum,B);
          else
          matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
          end

        else
          if nargin==1 || B==1
            res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.CMCumsum,1);
          elseif B == 2
            res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.CMCumsum,B);
          else
          matlabcoder.Util.throwException('MatrixView:plus:IllegalArgument', 'Illegal argument.');
          end
        end
      end

      %functions with special args in matlab functions map to vispl functions
      function res = exp10(this)
        coder.inline('never');
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Exp10);
      end 

      function res = sq2(this)
        coder.inline('never');
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Sq2);
      end

      function res = sumval(this)
        coder.inline('never');
        res = matlabcoder.OperationValue.of(this, matlabcoder.MatrixOperationEnum.Sumval);
      end
    
    %endregion Operators 
    
  end
  
  methods(Static)
    
    function res = isMatrixView(obj)
      res = isa(obj, 'matlabcoder.MatrixView');
    end
    
  end
  
end
