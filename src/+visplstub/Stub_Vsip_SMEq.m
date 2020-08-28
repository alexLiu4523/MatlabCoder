function Stub_Vsip_SMEq(operandA, operandB, this)
%STUB_VSIP_SMEQ
% call function:
%   void vsip_smleq_f(vsip_scalar_f alpha, const vsip_mview_f *b,const vsip_mview_bl *r);
%   r = a ~= b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA == operandB.viewData();

end

