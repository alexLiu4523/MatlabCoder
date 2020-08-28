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
    RightDivideScalar(9), %a./b,rdivide(a,b), Element-wise Right array division
    RightDivideMatrix(10),
    LeftDivideScalar(11), %a.\b,ldivide(a,b), Element-wise Left array division
    LeftDivideMatrix(12),

    MatrixTimesVector(13),
    MatrixTimesMatrix(14),

    LessThanMatrix(15),
    LessThanScalar(16),

    GreaterThanMatrix(17),
    GreaterThanScalar(18),

    LessEqualMatrix(19),
    LessEqualScalar(20),

    GreaterEqualMatrix(21),
    GreaterEqualScalar(22),

    NotEqualMatrix(23),
    NotEqualScalar(24),

    EqualToMatrix(25),
    EqualToScalar(26),

    LogicalAnd(27),
    LogicalOr(28),
    LogicalNot(29),

    CTranspose(30),
    Transpose(31),

    CMMean(87)
    MMean(88),
    Abs(89),
    Sumval(90),
    Sq2(91),
    CMCumsum(92),
    MCumsum(93),
    Conj(94),
    Exp10(95),

    
    SqrtR(97),
    SqrtC(98),
    Log(99),
    Cos(100),

    Min(101),
    Max(102)
  end
  
end

