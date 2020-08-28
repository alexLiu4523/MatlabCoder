function Stub_Vsip_CVMul(operandA, operandB, this)
%STUB_VSIP_CVMUL
% call function:
%   void (vsip_cvmul_type)(const vsip_cvview_d* a, const vsip_cvview_d* b, const vsip_cvview_d* r);
%   r = a .* b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() .* operandB.viewData();

end

