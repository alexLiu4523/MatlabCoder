function res = Stub_Vsip_CVDot(operandA,operandB)
%STUB_VSIP_CVDOT
% call function:
%   vsip_cscalar_f vsip_vdot_f(const vsip_cvview_f *a,const vsip_cvview_f *b);
%   r =	a*b;

  coder.inline('never');
  res = operandA.viewData()*operandB.viewData();

end