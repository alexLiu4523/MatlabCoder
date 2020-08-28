function Stub_Vsip_SVEq(operandA, operandB, this)
%STUB_VSIP_SVEQ
% call function:
%   void vsip_svleq_f(vsip_scalar_f alpha, const vsip_vview_f *b,const vsip_vview_bl *r);
%   r = a ~= b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA == operandB.viewData();

end

