function res = Stub_Vsip_MSumvalR(this)
%STUB_VSIP_MSUMVALR
% call function:
%   vsip_scalar_f vsip_msumval_f(const vsip_mview_f *a);
%   r =	sum(a);

  coder.inline('never');
  res = sum(operandA.viewData()(:));

end