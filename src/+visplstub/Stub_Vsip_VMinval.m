function [r,i] = Stub_Vsip_VMinval(this)
%STUB_VSIP_VMINVAL
% call function:
%   vsip_scalar_f vsip_vminval_f(const vsip_vview_f *a,vsip_scalar_vi *index);
%   [r,i] =	min(a);

  coder.inline('never');
  [r,i] = min(operandA.viewData());

end