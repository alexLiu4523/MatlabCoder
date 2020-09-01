function Stub_Vsip_CMTrans(operandA, this)
%STUB_VSIP_CMTRANS
% call function:
%   void vsip_cmtrans_f(const vsip_cmview_f *a, const vsip_cmview_f *r);
%   r = a';

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData()';

end