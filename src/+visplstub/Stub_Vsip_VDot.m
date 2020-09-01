function res = Stub_Vsip_VDot(operandA,operandB)
%STUB_VSIP_VDOT
% call function:
%   vsip_scalar_f vsip_vdot_f(const vsip_vview_f *a,const vsip_vview_f *b);
%   r =	a*b;

  coder.inline('never');
  res = operandA.viewData()*operandB.viewData();

end