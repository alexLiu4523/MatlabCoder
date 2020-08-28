function Stub_Vsip_UMinus(operandA, this)
%STUB_VSIP_UMINUS
% call function:
%   void (vsip_mneg_f)(vsip_scalar_f s, const vsip_mview_f* a, const vsip_mview_f* r);
%   r = s + a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = -operandA.viewData();

end
