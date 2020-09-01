function Stub_Vsip_RSCMSub(operandA, operandB, this)
%STUB_VSIP_RSCMMinus
% call function:
%   void (vsip_rscmsub_f)(vsip_scalar_f s, const vsip_cmview_f* a, const vsip_cmview_f* r);
%   r = s - a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA - operandB.viewData();

end

