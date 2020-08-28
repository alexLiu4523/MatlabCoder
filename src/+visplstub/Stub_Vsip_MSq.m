function Stub_Vsip_MSq(operandA, this)
%STUB_VSIP_MSQ
% call function:
%   void vsip_msq_f(const vsip_mview_f *a, const vsip_mview_f *r);
%   r = a.^2;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData().^2;

end