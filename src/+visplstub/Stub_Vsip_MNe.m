function Stub_Vsip_MNe(operandA, operandB, this)
%STUB_VSIP_MNE
% call function:
%   void vsip_mlne_f(const vsip_mview_f *a, const vsip_mview_f *b,const vsip_mview_bl *r);
%   r = a ~= b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() ~= operandB.viewData();

end

