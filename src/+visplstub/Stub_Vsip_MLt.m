function Stub_Vsip_MLt(operandA, operandB, this)
%STUB_VSIP_MLT
% call function:
%   void (vsip_mllt_type)(const vsip_mview_d* a, const vsip_mview_d* b, const vsip_mview_d* r);
%   r = a < b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() < operandB.viewData();

end

