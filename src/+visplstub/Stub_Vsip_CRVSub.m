function Stub_Vsip_CRVSub(operandA, operandB, this)
%STUB_VSIP_CRVSUB
% call function:
%   void (vsip_crvsub_type)(const vsip_cvview_d* a, const vsip_vview_d* b, const vsip_cvview_d* r);
%   r = a - b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() - operandB.viewData();

end

