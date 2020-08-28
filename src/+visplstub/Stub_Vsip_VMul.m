function Stub_Vsip_VMul(operandA, operandB, this)
%STUB_VSIP_VMUL
% call function:
%   void (vsip_vmul_type)(const vsip_vview_d* a, const vsip_vview_d* b, const vsip_vview_d* r);
%   r = a .* b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() .* operandB.viewData();

end

