function Stub_Vsip_MExp10(operandA, this)
%STUB_VSIP_MEXP10
% call function:
%   void vsip_mexp10_f(const vsip_mview_f *a, const vsip_mview_f *r);
%   r = mean(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = 10^(operandA.viewData());

end