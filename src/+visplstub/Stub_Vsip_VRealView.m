function Stub_Vsip_VRealView(operandA, this)
%STUB_VSIP_VREALVIEW
% call function:
%   vsip_vview_f vsip_vrealview_f(const vsip_cvview_f *a);
%   r = imag(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = real(operandA.viewData());

end