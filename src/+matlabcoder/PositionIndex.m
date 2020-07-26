classdef PositionIndex < matlabcoder.IndexBase
  
  properties
    positions
  end
  
  methods
    
    function this = PositionIndex(positions)
      this = this@matlabcoder.IndexBase(-1, -1);
      if isnumeric(positions)
        this.positions = positions;
      else
        throw(MException('PositionIndex:IllegalArgument', 'Illegal argument.'));
      end
    end
    
    function res = toVector(this)
      res = this.positions;
    end
    
    function res = toMatlabIndex(this)
      res = this.toVector();
    end
    
    function res = length(this)
      res = numel(this.positions);
    end
    
    function res = compose(otherIndex)
      throw(MException(''));
    end
    
  end
  
end
