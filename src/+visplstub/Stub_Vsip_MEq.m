function Stub_Vsip_MEq(operandA, operandB, this)
%STUB_VSIP_MEQ
% call function:
%   void vsip_mleq_f(const vsip_mview_f *a, const vsip_mview_f *b,const vsip_mview_bl *r);
%   r = a == b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() == operandB.viewData();

end
