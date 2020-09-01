function Stub_Vsip_CMEq(operandA, operandB, this)
%STUB_VSIP_CMEQ
% call function:
%   void vsip_cmleq_f(const vsip_cmview_f *a, const vsip_cmview_f *b,const vsip_mview_bl *r);
%   r = a == b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() == operandB.viewData();

end
