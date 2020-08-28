function Stub_Vsip_CMMag(operandA, this)
%STUB_VSIP_CMMAG
% call function:
%   void vsip_cmmag_f(const vsip_cmview_f *a, const vsip_cmview_f *r);
%   r = abs(a);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = abs(operandA.viewData());

end