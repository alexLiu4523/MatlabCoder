function Stub_Vsip_VNe(operandA, operandB, this)
%STUB_VSIP_VNE
% call function:
%   void vsip_vlne_f(const vsip_vview_f *a, const vsip_vview_f *b,const vsip_vview_bl *r);
%   r = a ~= b;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA.viewData() ~= operandB.viewData();

end

