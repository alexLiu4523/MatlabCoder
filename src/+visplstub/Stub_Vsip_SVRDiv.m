function Stub_Vsip_SVRDiv(operandA, operandB, this)
%STUB_VSIP_SVRDIV
% call function:
%   void (vsip_svdiv_f)(const vsip_scalar_f* a, const vsip_vview_f* b,  const vsip_vview_f* r);
%   r = a ./ b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA ./ operandB.viewData();

end

