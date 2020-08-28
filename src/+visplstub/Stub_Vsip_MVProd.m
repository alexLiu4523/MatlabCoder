function Stub_Vsip_MVProd(operandA, operandB, this)
%STUB_VSIP_SMADD
% call function:
%   void vsip_mprod_f(const vsip_mview_f *A, const vsip_vview_f *x,const vsip_vview_f *y);
%   C = A * B;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() * operandB.viewData();

end