function Stub_Vsip_CSVEq(operandA, operandB, this)
%STUB_VSIP_CSVEQ
% call function:
%   void vsip_csvleq_f(vsip_cscalar_f alpha, const vsip_cvview_f *b,const vsip_vview_bl *r);
%   r = a ~= b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA == operandB.viewData();

end