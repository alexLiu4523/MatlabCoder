classdef MatrixOperationEnum < uint8
  %MATRIXOPERTATION
  % @see [[https://www.mathworks.com/help/matlab/matlab_oop/implementing-operators-for-your-class.html]]
  
  enumeration
    PlusScalar(1), PlusMatrix(2),
    MinusScalar(3), MinusMatrix(4),
    UnaryMinus(5),
    UnaryPlus(6),
    Times(7), % a.*b, times(a,b), Element-wise multiplication
    MatrixTimes(8), %a*b, mtimes(a,b), Matrix multiplication
    Min(101),
    Max(102)
  end
  
end

