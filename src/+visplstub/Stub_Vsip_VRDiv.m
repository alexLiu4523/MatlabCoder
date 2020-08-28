function Stub_Vsip_VRDiv(operandA, operandB, this)
%STUB_VSIP_VRDIV
% call function:
%   void (vsip_vdiv_f)(const vsip_vview_f* a, const vsip_vview_f* b,  const vsip_cview_f* r);
%   r = a ./ b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() ./ operandB.viewData();

end

