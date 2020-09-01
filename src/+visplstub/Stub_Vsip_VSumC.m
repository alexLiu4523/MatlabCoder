function res = Stub_Vsip_VSumC(this)
%STUB_VSIP_VSUMC
% call function:
%   vsip_cscalar_f vsip_cvsumval_f(const vsip_cvview_f *a);
%   r =	sum(a);

  coder.inline('never');
  res = sum(operandA.viewData());

end