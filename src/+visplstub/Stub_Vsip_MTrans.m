function Stub_Vsip_MTrans(operandA, this)
%STUB_VSIP_MTRANS
% call function:
%   void vsip_mtrans_f(const vsip_mview_f *a, const vsip_mview_f *r);
%   r = a.';

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData().';

end