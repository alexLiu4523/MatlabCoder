function [r,i] = Stub_Vsip_VMinmg(this)
%STUB_VSIP_VMINMG
% call function:
%   vsip_scalar_f vsip_vminmgval_f(const vsip_vview_f *a,vsip_scalar_vi *index);
%   [r,i] =	min(abs(a));

  coder.inline('never');
  [r,i] = min(abs(operandA.viewData());

end