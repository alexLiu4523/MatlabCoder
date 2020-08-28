function Stub_Vsip_MOr(operandA, operandB, this)
%STUB_VSIP_MOR
% call function:
%   void vsip_mor_i(const vsip_mview_i *a, const vsip_mview_i *b,const vsip_mview_i *r);
%   r = a | b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() | operandB.viewData();

end