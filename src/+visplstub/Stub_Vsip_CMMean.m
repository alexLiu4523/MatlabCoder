function Stub_Vsip_CMMean(operandA, this)
%STUB_VSIP_CMMEAN
% call function:
%   void vsip_cmmeanval_f(const vsip_cmview_f *a, const vsip_cmview_f *r);
%   r = mean(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = mean(operandA.viewData());

end