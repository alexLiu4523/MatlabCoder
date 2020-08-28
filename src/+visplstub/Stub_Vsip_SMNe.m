function Stub_Vsip_SMNe(operandA, operandB, this)
%STUB_VSIP_SMNE
% call function:
%   void vsip_smlne_f(vsip_scalar_f alpha, const vsip_mview_f *b,const vsip_mview_bl *r);
%   r = a ~= b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA ~= operandB.viewData();

end

