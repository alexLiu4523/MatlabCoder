function Stub_Vsip_MSin(operandA, this)
%STUB_VSIP_MSIN
% call function:
%   void vsip_msin_f(const vsip_mview_f *a, const vsip_mview_f *r);
%   r = sin(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = sin(operandA.viewData());

end