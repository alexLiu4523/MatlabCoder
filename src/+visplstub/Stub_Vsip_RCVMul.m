function Stub_Vsip_RCVMul(operandA, operandB, this)
%STUB_VSIP_RCVMUL
% call function:
%   void (vsip_rcvmul_type)(const vsip_vview_d* a, const vsip_cvview_d* b, const vsip_cvview_d* r);
%   r = a .* b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() .* operandB.viewData();

end

