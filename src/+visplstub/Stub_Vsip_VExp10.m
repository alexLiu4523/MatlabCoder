function Stub_Vsip_VExp10(operandA, this)
%STUB_VSIP_VEXP10
% call function:
%   void vsip_vexp10_f(const vsip_vview_f *a, const vsip_vview_f *r);
%   r = cos(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = 10^(operandA.viewData());

end
