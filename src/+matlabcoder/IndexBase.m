classdef IndexBase
  % INDEXBASE
  % @see [[https://www.mathworks.com/help/matlab/math/array-indexing.html]]
  % Sub classes:
  %   UnitSpacedIndex:      x = A(1:10)
  %   RegularlySpacedIndex: x = A(1:5:10)
  %   AllIndex:             x = A(:)
  %   SinglePositionIndex:  x = A(1)
  %   PositionIndex:        x = A([1 3], [2 4])
  %   LogicalIndex:         x = A > 5
  %   EmptyIndex:           all indexes leads to no elements like A(1:0)
  
  properties
    % Note: -1 means index is not specified
    startIndex = -1
    endIndex = -1
  end
  
  methods
    
    function this = IndexBase(startIndex, endIndex)
      this.startIndex = startIndex;
      this.endIndex = endIndex;
    end
    
  end
  
  methods(Abstract)
    
    toVector(this);
    
    toMatlabIndex(this);
    
    length(this);
    
    compose(otherIndex);
    
  end
  
  methods(Static)
    
    function res = isUnitSpacedIndex(index)
      res = isa(index, 'matlabcoder.UnitSpacedIndex');
    end
    
    function res = isRegularlySpacedIndex(index)
      res = isa(index, 'matlabcoder.RegularlySpacedIndex');
    end
    
    function res = isLogicalIndex(index)
      res = isa(index, 'matlabcoder.LogicalIndexIndex');
    end

    function res = isAllIndex(index)
      res = isa(index, 'matlabcoder.AllIndex');
      % TODO: If we can make sure that there is only one instance(`matlabcoder.AllIndex.INSTANCE`) of type `matlabcoder.AllIndex`
      %       then we can just do reference equal to see whether `index` is type `matlabcoder.AllIndex`.
    end
    
    function res = isVectorableIndex(index)
      res = matlabcoder.IndexBase.isUnitSpacedIndex(index) || matlabcoder.IndexBase.isRegularlySpacedIndex(index);
    end
    
  end
  
end
