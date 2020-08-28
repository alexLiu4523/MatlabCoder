function Stub_Vsip_MAnd(operandA, operandB, this)
%STUB_VSIP_MAND
% call function:
%   void vsip_mand_i(const vsip_mview_i *a, const vsip_mview_i *b,const vsip_mview_i *r);
%   r = a & b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() & operandB.viewData();

end