function Stub_Vsip_VConj(operandA, this)
%STUB_VSIP_VCONJ
% call function:
%   void vsip_cvconj_f(const vsip_cvview_f *a, const vsip_cvview_f *r);
%   r = conj(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = conj(operandA.viewData());

end
