function Stub_Vsip_RSCVAdd(operandA, operandB, this)
%STUB_VSIP_RSCVADD
% call function:
%   void (vsip_rscvadd_d)(vsip_scalar_d s, const vsip_cvview_d* a, const vsip_cvview_d* r);
%   r = s + a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() + operandB;

end

%exchange of args happens when this func is called