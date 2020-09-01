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

    MatrixMTimesVector(13),
    MatrixMTimesMatrix(14),
    CMatrixMTimesMatrix(15),

    LessThanMatrix(16),
    LessThanScalar(17),

    GreaterThanMatrix(18),
    GreaterThanScalar(19),

    LessEqualMatrix(20),
    LessEqualScalar(21),

    GreaterEqualMatrix(22),
    GreaterEqualScalar(23),

    NotEqualMatrix(24),
    NotEqualScalar(25),

    EqualToMatrix(26),
    EqualToScalar(27),

    LogicalAnd(28),
    LogicalOr(29),
    LogicalNot(30),

    CTranspose(31),
    Transpose(32),
    CPlusMatrix(33),

    MinusCMatrix(34),
    CMinusRMatrix(35),
    CMinusMatrix(36),

    ScalarMinusMatrix(37),
    ScalarMinusCMatrix(38),
    CScalarMinusMatrix(39),

    CEqualToMatrix(40),
    CCTranspose(41),


    Sin(84),
    ConjMul(85),
    Euler(86),

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

    Min(110),
    Max(111)
  end
  
end
