function Stub_Vsip_CMSub(operandA, operandB, this)
%STUB_VSIP_CMSUB
% call function:
%   void (vsip_cmsub_type)(const vsip_cmview_d* a, const vsip_cmview_d* b, const vsip_cmview_d* r);
%   r = a - b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() - operandB.viewData();

end

