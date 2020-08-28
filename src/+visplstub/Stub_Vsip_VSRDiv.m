function Stub_Vsip_VSRDiv(operandA, operandB, this)
%STUB_VSIP_VSRDIV
% call function:
%   void (vsip_vsdiv_f)(const vsip_vview_f* a, const vsip_scalar_f* b,  const vsip_vview_f* r);
%   r = a ./ b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() ./ operandB;

end

