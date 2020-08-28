function Stub_Vsip_VExpC(operandA, this)
%STUB_VSIP_VEXPC
% call function:
%   void vsip_cvexp_f(const vsip_cvview_f *a, const vsip_cvview_f *r);
%   r = cos(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = exp(operandA.viewData());

end
