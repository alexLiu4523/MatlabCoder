function Stub_Vsip_MAdd(operandA, operandB, this)
%STUB_VSIP_MADD
% call function:
%   void (vsip_madd_type)(const vsip_mview_d* a, const vsip_mview_d* b, const vsip_mview_d* r);
%   r = a + b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() + operandB.viewData();

end

