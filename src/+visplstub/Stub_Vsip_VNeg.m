function Stub_Vsip_VNeg(operandA, this)
%STUB_VSIP_VNEG
% call function:
%   void vsip_vneg_i(const vsip_vview_i *a, const vsip_vview_i *r);
%   r = -a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = -operandA.viewData();

end