function Stub_Vsip_RSCVSub(operandA, operandB, this)
%STUB_VSIP_RSCVSUB
% call function:
%   void (vsip_rscvsub_d)(vsip_scalar_d s, const vsip_cvview_d* a, const vsip_cvview_d* r);
%   r = s - a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA - operandB.viewData();

end

%exchange of args happens when this func is called