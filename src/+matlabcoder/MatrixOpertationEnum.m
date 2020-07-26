classdef MatrixOpertationEnum < uint8
  %MATRIXOPERTATION
  % @see [[https://www.mathworks.com/help/matlab/matlab_oop/implementing-operators-for-your-class.html]]
  
  enumeration
    PlusScalar(0), PlusMatrix(1),
    MinusScalar(2), MinusMatrix(3),
    UnaryMinus(4),
    UnaryPlus(5),
    Times(6), % a.*b, times(a,b), Element-wise multiplication
    MatrixTimes(7), %a*b, mtimes(a,b), Matrix multiplication
    Min(101),
    Max(102)
  end
  
end

