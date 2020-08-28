function Stub_Vsip_VImagView(operandA, this)
%STUB_VSIP_VIMAGVIEW
% call function:
%   vsip_vview_f vsip_vimagview_f(const vsip_cvview_f *a);
%   r = imag(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = imag(operandA.viewData());

end