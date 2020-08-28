function Stub_Vsip_MSqrtC(operandA, this)
%STUB_VSIP_MSQRTC
% call function:
%   void vsip_cmsqrt_f(const vsip_cmview_f *a, const vsip_cmview_f *r);
%   r = sqrt(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = sqrt(operandA.viewData());

end