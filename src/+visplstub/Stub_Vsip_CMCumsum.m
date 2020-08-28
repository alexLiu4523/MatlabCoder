function Stub_Vsip_CMCumsum(operandA, operandB, this)
%STUB_VSIP_CMCUMSUM
% call function:
%   void (vsip_cmcumsum_f)(const vsip_cmview_f* a, vsip_major dir, const vsip_cmview_f* r);
%   r = cumsum(a,1) or cumsum(a,2);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = cumsum(operandA.viewData(),operandB);

end

