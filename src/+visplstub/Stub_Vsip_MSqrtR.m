function Stub_Vsip_MSqrtR(operandA, this)
%STUB_VSIP_MSQRTR
% call function:
%   void vsip_msqrt_f(const vsip_mview_f *a, const vsip_mview_f *r);
%   r = sqrt(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = sqrt(operandA.viewData());

end