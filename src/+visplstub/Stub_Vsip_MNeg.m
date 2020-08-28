function Stub_Vsip_MNeg(operandA, this)
%STUB_VSIP_MNEG
% call function:
%   void vsip_mneg_i(const vsip_mview_i *a, const vsip_mview_i *r);
%   r = -a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = -operandA.viewData();

end