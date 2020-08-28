function Stub_Vsip_CMConj(operandA, this)
%STUB_VSIP_CMCONJ
% call function:
%   void vsip_cmconj_f(const vsip_cmview_f *a, const vsip_cmview_f *r);
%   r = conj(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = conj(operandA.viewData());

end