function Stub_Vsip_SVSub(operandA, operandB, this)
%STUB_VSIP_SVSUB
% call function:
%   void (vsip_svsub_d)(vsip_scalar_d s, const vsip_vview_d* a, const vsip_vview_d* r);
%   r = s + a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() + operandB;

end

%exchange of args happens when this func is called