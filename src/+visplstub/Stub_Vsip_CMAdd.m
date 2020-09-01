function Stub_Vsip_CMAdd(operandA, operandB, this)
%STUB_VSIP_CMADD
% call function:
%   void (vsip_cmadd_type)(const vsip_cmview_d* a, const vsip_cmview_d* b, const vsip_cmview_d* r);
%   r = a + b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() + operandB.viewData();

end

