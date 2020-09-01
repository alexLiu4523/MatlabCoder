function Stub_Vsip_CRMSub(operandA, operandB, this)
%STUB_VSIP_CRMSUB
% call function:
%   void (vsip_crmsub_type)(const vsip_cmview_d* a, const vsip_mview_d* b, const vsip_cmview_d* r);
%   r = a - b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() - operandB.viewData();

end

