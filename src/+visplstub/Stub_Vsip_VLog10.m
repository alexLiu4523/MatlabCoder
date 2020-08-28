function Stub_Vsip_VLog10(operandA, this)
%STUB_VSIP_VLOG10
% call function:
%   void vsip_vlog10_f(const vsip_vview_f *a, const vsip_vview_f *r);
%   r = cos(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = log(operandA.viewData());

end
