function Stub_Vsip_CVRDiv(operandA, operandB, this)
%STUB_VSIP_CVRDIV
% call function:
%   void (vsip_cvdiv_f)(const vsip_cvview_f* a, const vsip_cvview_f* b,  const vsip_cview_f* r);
%   r = a ./ b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() ./ operandB.viewData();

end

