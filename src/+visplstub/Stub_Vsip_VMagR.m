function Stub_Vsip_VMagR(operandA, this)
%STUB_VSIP_VMAGR
% call function:
%   void vsip_vmag_f(const vsip_vview_f *a, const vsip_vview_f *r);
%   r = abs(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = abs(operandA.viewData());

end