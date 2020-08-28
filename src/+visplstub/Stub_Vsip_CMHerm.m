function Stub_Vsip_CMHerm(operandA, this)
%STUB_VSIP_CMHERM
% call function:
%   void vsip_cmherm_f(const vsip_cmview_f *a, const vsip_cmview_f *r);
%   r = a | b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData()';

end