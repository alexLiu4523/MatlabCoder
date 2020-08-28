function Stub_Vsip_MLog10(operandA, this)
%STUB_VSIP_MLOG10
% call function:
%   void vsip_mlog10_f(const vsip_mview_f *a, const vsip_mview_f *r);
%   r = log(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = log(operandA.viewData());

end