function Stub_Vsip_CSMSub(operandA, operandB, this)
%STUB_VSIP_CSMMinus
% call function:
%   void (vsip_csmsub_f)(vsip_cscalar_f s, const vsip_cmview_f* a, const vsip_cmview_f* r);
%   r = s - a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA - operandB.viewData();

end

