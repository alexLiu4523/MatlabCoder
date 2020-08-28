function Stub_Vsip_VMagC(operandA, this)
%STUB_VSIP_VMAGC
% call function:
%   void vsip_cvmag_f(const vsip_cvview_f *a, const vsip_cvview_f *r);
%   r = abs(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = abs(operandA.viewData());

end