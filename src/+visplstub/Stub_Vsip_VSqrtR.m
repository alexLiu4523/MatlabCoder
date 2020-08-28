function Stub_Vsip_VSqrtR(operandA, this)
%STUB_VSIP_VSQRTR
% call function:
%   void vsip_vsqrt_f(const vsip_vview_f *a, const vsip_vview_f *r);
%   r = sin(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = sqrt(operandA.viewData());

end