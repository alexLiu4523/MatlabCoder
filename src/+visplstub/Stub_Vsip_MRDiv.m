function Stub_Vsip_MRDiv(operandA, operandB, this)
%STUB_VSIP_SMADD
% call function:
%   void (vsip_mdiv_f)(const vsip_mview_f* a, const vsip_mview_f* b,  const vsip_mview_f* r);
%   r = a ./ b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() ./ operandB.viewData();

end

