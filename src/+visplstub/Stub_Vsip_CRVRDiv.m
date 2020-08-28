function Stub_Vsip_CRVRDiv(operandA, operandB, this)
%STUB_VSIP_CRVRDIV
% call function:
%   void (vsip_crvdiv_f)(const vsip_cvview_f* a, const vsip_vview_f* b,  const vsip_cview_f* r);
%   r = a ./ b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() ./ operandB.viewData();

end

