function Stub_Vsip_SMLt(operandA, operandB, this)
%STUB_VSIP_SMLT
% call function:
%   void (vsip_smllt_f)(vsip_scalar_f s, const vsip_mview_f* a, const vsip_mview_f* r);
%   r = s > a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA < operandB.viewData();

end