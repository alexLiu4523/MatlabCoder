function Stub_Vsip_VMin2(operandA,operandB,this)
%STUB_VSIP_VMIN2
% call function:
%   void vsip_vmin_f(const vsip_vview_f *a,const vsip_vview_f *b,const vsip_vview_f *r);
%   r =	min(a,b);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = min(operandA.viewData(),operandB.viewData());

end