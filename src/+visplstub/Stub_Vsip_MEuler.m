function Stub_Vsip_MEuler(operandA, this)
%STUB_VSIP_MEULER
% call function:
%   void vsip_meuler_f(const vsip_mview_f *a, const vsip_cmview_f *r);
%   r = exp(j*a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = exp(j*operandA.viewData());

end