function Stub_Vsip_VEuler(operandA, this)
%STUB_VSIP_VEULER
% call function:
%   void vsip_veuler_f(const vsip_vview_f *a, const vsip_cvview_f *r);
%   r = exp(j*a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = exp(j*operandA.viewData());

end