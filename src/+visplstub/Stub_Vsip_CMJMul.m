function Stub_Vsip_CMJMul(operandA, operandB, this)
%STUB_VSIP_CMJMUL_DOUBLE 
% call function:
%   void (vsip_cmjmul_d)(vsip_cmview_d a, const vsip_cmview_d* b, const vsip_cmview_d* r);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() .* conj(operandB.viewData());

end
