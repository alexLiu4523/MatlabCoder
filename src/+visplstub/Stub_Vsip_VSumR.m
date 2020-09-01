function res = Stub_Vsip_VSumR(this)
%STUB_VSIP_VSUMR
% call function:
%   vsip_scalar_f vsip_vsumval_f(const vsip_vview_f *a);
%   r =	sum(a);

  coder.inline('never');
  res = sum(operandA.viewData());

end