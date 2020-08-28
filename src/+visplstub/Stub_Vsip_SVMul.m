function Stub_Vsip_SVMul(operandA, operandB, this)
%STUB_VSIP_SVMUL
% call function:
%   void (vsip_svmul_type)(const vsip_scalar_d* a, const vsip_vview_d* b, const vsip_vview_d* r);
%   r = a .* b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA .* operandB.viewData();

end

