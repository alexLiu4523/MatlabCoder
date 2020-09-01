function Stub_Vsip_CVJMul(operandA, operandB, this)
%STUB_VSIP_CVJMUL
% call function:
%   void (vsip_cvjmul_type)(const vsip_cvview_d* a, const vsip_cvview_d* b, const vsip_cvview_d* r);
%   r = a .* conj(b);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() .* conj(operandB.viewData());

end

