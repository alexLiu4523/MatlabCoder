function Stub_Vsip_MSRDiv(operandA, operandB, this)
%STUB_VSIP_SMADD
% call function:
%   void (vsip_msdiv_f)(const vsip_mview_f* a, vsip_scalar_f s,  const vsip_mview_f* r);
%   r = a ./ s;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() ./ operandB;

end

