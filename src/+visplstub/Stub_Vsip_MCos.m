function Stub_Vsip_MCos(operandA, this)
%STUB_VSIP_MCOS
% call function:
%   void vsip_mcos_f(const vsip_mview_f *a, const vsip_mview_f *r);
%   r = cos(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = cos(operandA.viewData());

end