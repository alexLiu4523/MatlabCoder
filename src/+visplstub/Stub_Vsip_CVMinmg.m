function [r,i] = Stub_Vsip_CVMinmg(this)
%STUB_VSIP_CVMINMG
% call function:
%   vsip_scalar_f vsip_vcminmgsqval_f(const vsip_cvview_f *a,vsip_scalar_vi *index);
%   [r,i] =	min(abs(a));

  coder.inline('never');
  [r,i] = min(abs(operandA.viewData());

end