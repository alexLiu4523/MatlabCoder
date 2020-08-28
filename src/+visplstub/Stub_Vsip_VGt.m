function Stub_Vsip_VGt(operandA, operandB, this)
%STUB_VSIP_VGT
% call function:
%   void (vsip_vlgt_type)(const vsip_vview_d* a, const vsip_vview_d* b, const vsip_vview_d* r);
%   r = a < b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() > operandB.viewData();

end