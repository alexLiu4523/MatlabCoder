function Stub_Vsip_MNot(operandA, this)
%STUB_VSIP_MNOT
% call function:
%   void vsip_mnot_i(const vsip_mview_i *a, const vsip_mview_i *r);
%   r = ~a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = ~operandA.viewData();

end