function Stub_Vsip_CMProd(operandA, operandB, this)
%STUB_VSIP_CMPROD
% call function:
%   void vsip_cmprod_f(const vsip_cmview_f *A, const vsip_cmview_f *B,const vsip_cmview_f *C);
%   C = A * B;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() * operandB.viewData();

end