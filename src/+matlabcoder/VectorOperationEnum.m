classdef VectorOperationEnum < uint8
  %VECTOROPERTATION
  % @see [[https://www.mathworks.com/help/matlab/matlab_oop/implementing-operators-for-your-class.html]]
  
  enumeration
    PlusScalar(1),PlusVector(2),
    CPlusScalar(3),CPlusVector(4),
    CPlusRScalar(5),
    MinusScalar(6), MinusVector(7),
    UnaryMinus(8),
    UnaryPlus(9),
    
    RightDivideScalar(10), %a./b,rdivide(a,b), Element-wise Right array division
    RightDivideVector(11),
    CRightDivideVector(12),
    CRightDivideRVector(13),
    LeftDivideScalar(14), %a.\b,ldivide(a,b), Element-wise Left array division
    LeftDivideVector(15),

    TimesVector(16),
    TimesCVector(17),
    TimesScalar(18),
    CTimesVector(19),
    CTimesScalar(20),

    LessThanVector(21),
    LessThanScalar(22),

    GreaterThanVector(23),
    GreaterThanScalar(24),

    LessEqualVector(25),
    LessEqualScalar(26),

    GreaterEqualVector(27),
    GreaterEqualScalar(28),

    NotEqualVector(29),
    NotEqualScalar(30),

    EqualToVector(31),
    EqualToScalar(32),

    LogicalAnd(33),
    LogicalOr(34),
    LogicalNot(35),

    CTranspose(36),
    Transpose(37),

    Sq2(84),
    Real(85),
    Imag(86),    
    MeanC(87),
    MeanR(88),
    AbsC(89),
    AbsR(90),
    CumsumC(91),
    CumsumR(92),
    Conj(93),
    SqrtC(94),
    SqrtR(95),
    Sin(96),
    Exp10(97)
    ExpC(98),
    ExpR(99),
    Cos(100),
    Min(101),
    Max(102)
  end

end
