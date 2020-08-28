function Stub_Vsip_MCumsum(operandA, operandB, this)
%STUB_VSIP_MCUMSUM
% call function:
%   void (vsip_mcumsum_f)(const vsip_mview_f* a, vsip_major dir, const vsip_mview_f* r);
%   r = cumsum(a,1) or cumsum(a,2);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = cumsum(operandA.viewData(),operandB);

end

