function Stub_Vsip_VExpR(operandA, this)
%STUB_VSIP_VEXPR
% call function:
%   void vsip_vexp_f(const vsip_vview_f *a, const vsip_vview_f *r);
%   r = cos(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = exp(operandA.viewData());

end
