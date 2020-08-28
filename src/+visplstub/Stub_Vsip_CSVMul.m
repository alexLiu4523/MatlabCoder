function Stub_Vsip_CSVMul(operandA, operandB, this)
%STUB_VSIP_CSVMUL
% call function:
%   void (vsip_csvmul_type)(const vsip_cscalar_d* a, const vsip_cvview_d* b, const vsip_cvview_d* r);
%   r = a .* b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA .* operandB.viewData();

end

