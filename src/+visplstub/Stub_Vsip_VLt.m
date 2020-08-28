function Stub_Vsip_VLt(operandA, operandB, this)
%STUB_VSIP_VLT
% call function:
%   void (vsip_vllt_type)(const vsip_vview_d* a, const vsip_vview_d* b, const vsip_vview_d* r);
%   r = a < b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() < operandB.viewData();

end

