function Stub_Vsip_MMean(operandA, this)
%STUB_VSIP_MMEAN
% call function:
%   void vsip_mmeanval_f(const vsip_mview_f *a, const vsip_mview_f *r);
%   r = mean(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = mean(operandA.viewData());

end