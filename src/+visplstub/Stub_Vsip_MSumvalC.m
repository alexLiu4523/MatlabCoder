function res = Stub_Vsip_MSumvalC(this)
%STUB_VSIP_MSUMVALC
% call function:
%   vsip_cscalar_f vsip_cmsumval_f(const vsip_cmview_f *a);
%   r =	sum(a);

  coder.inline('never');
  res = sum(operandA.viewData()(:));

end