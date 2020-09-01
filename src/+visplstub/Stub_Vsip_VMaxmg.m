function [r,i] = Stub_Vsip_VMaxmg(this)
%STUB_VSIP_VMAXMG
% call function:
%   vsip_scalar_f vsip_vmaxmgval_f(const vsip_vview_f *a,vsip_scalar_vi *index);
%   [r,i] =	max(abs(a));

  coder.inline('never');
  [r,i] = max(abs(operandA.viewData());

end