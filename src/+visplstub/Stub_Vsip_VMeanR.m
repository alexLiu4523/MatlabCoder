function Stub_Vsip_VMeanR(operandA, this)
%STUB_VSIP_VMEANR
% call function:
%   void vsip_vmeanval_f(const vsip_vview_f *a, const vsip_vview_f *r);
%   r = mean(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = mean(operandA.viewData());

end