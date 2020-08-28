function Stub_Vsip_VNot(operandA, this)
%STUB_VSIP_VNOT
% call function:
%   void vsip_vnot_i(const vsip_vview_i *a, const vsip_vview_i *r);
%   r = ~a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = ~operandA.viewData();

end