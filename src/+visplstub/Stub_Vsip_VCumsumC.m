function Stub_Vsip_VCumsumC(operandA, this)
%STUB_VSIP_VCUMSUMC
% call function:
%   void vsip_cvcumsum_f(const vsip_cvview_f *a, const vsip_cvview_f *r);
%   r = sin(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = cumsum(operandA.viewData());

end