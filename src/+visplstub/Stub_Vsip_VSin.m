function Stub_Vsip_VSin(operandA, this)
%STUB_VSIP_VSIN
% call function:
%   void vsip_vsin_f(const vsip_vview_f *a, const vsip_vview_f *r);
%   r = sin(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = sin(operandA.viewData());

end