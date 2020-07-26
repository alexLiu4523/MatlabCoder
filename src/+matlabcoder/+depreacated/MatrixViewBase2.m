classdef MatrixViewBase2
  %MatrixViewBase2

  properties
    matrixHandle
    xIndex
    yIndex
  end

  methods

    function this = MatrixView(matrixHandle, xIndex, yIndex)
      this.matrixHandle = matrixHandle;
      this.xIndex = xIndex;
      this.yIndex = yIndex;
    end

%     function res = subsref(this, s)
%       if (isscalar(s) && ischar(s.type) && strcmp(s.type, '()'))
%         res = matlabcoder.MatrixView(this.matrixHandle);
%       else
%         res = builtin('subsref', this, s);
%       end
%     end
    
    function res = subview(this, xSubIndex, ySubIndex)
      % TODO
      res = matlabcoder.MatrixView(this.matrixHandle);
    end

    function res = subsasgn(this, s, B)
      res = this;
      % if (B.isa)
    end

    function res = subsasgn2(this, index1, index2, B)
      res = this;
      % if (B.isa)
    end

    % https://www.mathworks.com/help/matlab/ref/plus.html
    function res = plus(this, B)
      if isscalar(B)
        res = this.viewData() + B;
      elseif isa(B, 'matlabcoder.MatrixView')
        res = this.viewData() * B.viewData();
      else
        throw(MException(''));
      end
    end
    
    function res = viewData(this)
      res = this.matrixHandle.data(this.rowStart : this.rowStep : this.rowEnd,...
                                   this.columnStart : this.columnStep : this.columnEnd);
    end

  end

  methods(Static)

    function view = subviewWithOnlyRowIndex(matrixHandle, rowIndex)
      view = MatrixView(matrixHandle);
      view.rowStart = rowIndex;
      view.rowEnd = rowIndex + 1;
    end

    function view = subviewWithRowStartAndEnd(matrixHandle, rowStart, rowEnd)
      view = MatrixView(matrixHandle);
      view.rowStart = rowStart;
      view.rowEnd = rowEnd;
    end

  end

end
