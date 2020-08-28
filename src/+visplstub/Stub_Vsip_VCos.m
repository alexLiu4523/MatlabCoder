function Stub_Vsip_VCos(operandA, this)
%STUB_VSIP_VCOS
% call function:
%   void vsip_vcos_f(const vsip_vview_f *a, const vsip_vview_f *r);
%   r = cos(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = cos(operandA.viewData());

end
