function [r,i] = Stub_Vsip_CVMaxmg(this)
%STUB_VSIP_CVMAXMG
% call function:
%   vsip_scalar_f vsip_vcmaxmgsqval_f(const vsip_cvview_f *a,vsip_scalar_vi *index);
%   [r,i] =	max(abs(a));

  coder.inline('never');
  [r,i] = max(abs(operandA.viewData());

end