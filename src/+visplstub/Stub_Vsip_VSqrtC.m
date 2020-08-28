function Stub_Vsip_VSqrtC(operandA, this)
%STUB_VSIP_VSQRTC
% call function:
%   void vsip_cvsqrt_f(const vsip_cvview_f *a, const vsip_cvview_f *r);
%   r = sin(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = sqrt(operandA.viewData());

end