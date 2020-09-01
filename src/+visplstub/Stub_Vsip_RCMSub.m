function Stub_Vsip_RCMSub(operandA, operandB, this)
%STUB_VSIP_RCMSUB
% call function:
%   void (vsip_rcmsub_type)(const vsip_mview_d* a, const vsip_cmview_d* b, const vsip_cmview_d* r);
%   r = a - b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() - operandB.viewData();

end

