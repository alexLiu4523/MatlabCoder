function Stub_Vsip_VCumsumR(operandA, this)
%STUB_VSIP_VCUMSUMR
% call function:
%   void vsip_vcumsum_f(const vsip_vview_f *a, const vsip_vview_f *r);
%   r = sin(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = cumsum(operandA.viewData());

end