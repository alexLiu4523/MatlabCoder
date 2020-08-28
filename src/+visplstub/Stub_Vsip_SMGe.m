function Stub_Vsip_SMGe(operandA, operandB, this)
%STUB_VSIP_SMGE
% call function:
%   void (vsip_smlge_f)(vsip_scalar_f s, const vsip_mview_f* a, const vsip_mview_f* r);
%   r = s > a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA > operandB.viewData();

end

