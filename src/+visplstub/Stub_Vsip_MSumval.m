function Stub_Vsip_MSumval(operandA, this)
%STUB_VSIP_MSUMVAL
% call function:
%   vsip_scalar_f vsip_msumval_f(const vsip_mview_f *a);
%   r = sum(a(:));

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = sum(operandA.viewData()(:));

end