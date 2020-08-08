function Stub_Vsip_SMAdd(operandA, operandB, this)
%STUB_VSIP_SMADD
% call function:
%   void (vsip_smadd_f)(vsip_scalar_f s, const vsip_mview_f* a, const vsip_mview_f* r);
%   r = s + a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() + operandB;

end

