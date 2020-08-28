function Stub_Vsip_VLEq(operandA, operandB, this)
%STUB_VSIP_VLEQ
% call function:
%   void (vsip_vleq_type)(const vsip_vview_d* a, const vsip_vview_d* b, const vsip_vview_d* r);
%   r = a <= b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() <= operandB.viewData();

end

