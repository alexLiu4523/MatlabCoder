classdef VectorOperationEnum < uint8
  %VECTOROPERTATION
  % @see [[https://www.mathworks.com/help/matlab/matlab_oop/implementing-operators-for-your-class.html]]
  
  enumeration
    PlusScalar(1),PlusVector(2),
    CPlusScalar(3),CPlusVector(4),
    CPlusRScalar(5),

    MinusVector(6),
    MinusCVector(7),
    CMinusRVector(8),
    CMinusVector(9),
    ScalarMinusVector(10),
    ScalarMinusCVector(11),
    CScalarMinusVector(12),

    UnaryMinus(13),
    UnaryPlus(14),
    
    RightDivideScalar(15), %a./b,rdivide(a,b), Element-wise Right array division
    RightDivideVector(16),
    CRightDivideVector(17),
    CRightDivideRVector(18),
    ScalarRightDivideVector(19),

    LeftDivideScalar(20), %a.\b,ldivide(a,b), Element-wise Left array division
    LeftDivideVector(21),

    TimesVector(22),
    CTimesVector(23),
    TimesCVector(24),
    ScalarTimesVector(25),
    CScalarTimesVector(26),
    RScalarTimesCVector(27),

    LessThanVector(28),
    LessThanScalar(29),

    GreaterThanVector(30),
    GreaterThanScalar(31),

    LessEqualVector(32),
    LessEqualScalar(33),

    GreaterEqualVector(34),
    GreaterEqualScalar(35),

    NotEqualVector(36),
    NotEqualScalar(37),

    EqualToVector(38),
    EqualToScalar(39),

    LogicalAnd(40),
    LogicalOr(41),
    LogicalNot(42),

    CTranspose(43),
    Transpose(44),
    
    CEqualToVector(45),
    CEqualToScalar(46),

    ScalarTimesCVector(47),
    
    Log(77),
    ConjMul(78),
    Euler(79),
    MinAbsC(80),
    MinAbsR(81),
    MaxAbsC(82),
    MaxAbsR(83),
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
