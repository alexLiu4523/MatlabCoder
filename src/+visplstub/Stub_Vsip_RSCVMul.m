function Stub_Vsip_RSCVMul(operandA, operandB, this)
%STUB_VSIP_RSCVMUL
% call function:
%   void (vsip_rscsvmul_type)(const vsip_scalar_d* a, const vsip_cvview_d* b, const vsip_cvview_d* r);
%   r = a .* b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA .* operandB.viewData();

end

