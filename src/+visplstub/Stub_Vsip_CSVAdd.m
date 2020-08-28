function Stub_Vsip_CSVAdd(operandA, operandB, this)
%STUB_VSIP_CSVADD
% call function:
%   void (vsip_csvadd_d)(vsip_cscalar_d s, const vsip_cvview_d* a, const vsip_cvview_d* r);
%   r = s + a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() + operandB;

end

%exchange of args happens when this func is called