function Stub_Vsip_VMeanC(operandA, this)
%STUB_VSIP_VMEANC
% call function:
%   void vsip_cvmeanval_f(const vsip_cvview_f *a, const vsip_cvview_f *r);
%   r = mean(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = mean(operandA.viewData());

end