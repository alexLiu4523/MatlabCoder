function Stub_Vsip_VOr(operandA, operandB, this)
%STUB_VSIP_VOR
% call function:
%   void vsip_vor_i(const vsip_vview_i *a, const vsip_vview_i *b,const vsip_vview_i *r);
%   r = a | b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() | operandB.viewData();

end