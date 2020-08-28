function Stub_Vsip_SMMul_Double(operandB, operandA, this)
%STUB_VSIP_SMMUL_DOUBLE 
% call function:
%   void (vsip_smmul_d)(vsip_scalar_d b, const vsip_mview_d* a, const vsip_mview_d* r);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() .* operandB;

end
