function Stub_Vsip_CVEq(operandA, operandB, this)
%STUB_VSIP_CVEQ
% call function:
%   void vsip_cvleq_f(const vsip_cvview_f *a, const vsip_cvview_f *b,const vsip_vview_bl *r);
%   r = a == b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() == operandB.viewData();

end
