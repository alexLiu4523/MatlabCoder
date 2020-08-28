function Stub_Vsip_MProd(operandA, operandB, this)
%STUB_VSIP_SMADD
% call function:
%   void vsip_mprod_f(const vsip_mview_f *A, const vsip_mview_f *B,const vsip_mview_f *C);
%   C = A * B;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() * operandB.viewData();

end