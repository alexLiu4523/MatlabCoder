function Stub_Vsip_CSVSub(operandA, operandB, this)
%STUB_VSIP_CSVSUB
% call function:
%   void (vsip_csvsub_d)(vsip_cscalar_d s, const vsip_cvview_d* a, const vsip_cvview_d* r);
%   r = s - a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA - operandB.viewData();

end

%exchange of args happens when this func is called