function Stub_Vsip_VSq2(operandA, this)
%STUB_VSIP_VSQ2
% call function:
%   void vsip_vsq_f(const vsip_vview_f *a, const vsip_vview_f *r);
%   r = a.^2;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = (operandA.viewData()).^2;

end