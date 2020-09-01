function [r,i] = Stub_Vsip_VMaxval(this)
%STUB_VSIP_VMAXVAL
% call function:
%   vsip_scalar_f vsip_vmaxval_f(const vsip_vview_f *a,vsip_scalar_vi *index);
%   [r,i] =	max(a);

  coder.inline('never');
  [r,i] = max(operandA.viewData());

end