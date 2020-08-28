function Stub_Vsip_CVAdd(operandA, operandB, this)
%STUB_VSIP_CVADD
% call function:
%   void (vsip_vadd_type)(const vsip_cvview_d* a, const vsip_cvview_d* b, const vsip_cvview_d* r);
%   r = a + b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() + operandB.viewData();

end

