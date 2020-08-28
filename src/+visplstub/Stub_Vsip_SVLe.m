function Stub_Vsip_SVLe(operandA, operandB, this)
%STUB_VSIP_SVLE
% call function:
%   void (vsip_svlle_f)(vsip_scalar_f s, const vsip_vview_f* a, const vsip_vview_f* r);
%   r = s < a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA < operandB.viewData();

end

