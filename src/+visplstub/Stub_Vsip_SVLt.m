function Stub_Vsip_SVLt(operandA, operandB, this)
%STUB_VSIP_SVLT
% call function:
%   void (vsip_svllt_f)(vsip_scalar_f s, const vsip_mview_f* a, const vsip_mview_f* r);
%   r = s > a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA < operandB.viewData();

end