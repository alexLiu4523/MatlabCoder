function Stub_Vsip_VGe(operandA, operandB, this)
%STUB_VSIP_VGE
% call function:
%   void (vsip_vge_type)(const vsip_vview_d* a, const vsip_vview_d* b, const vsip_vview_d* r);
%   r = a >= b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() >= operandB.viewData();

end

