function Stub_Vsip_VMax2(operandA,operandB,this)
%STUB_VSIP_VMAX2
% call function:
%   void vsip_vmax_f(const vsip_vview_f *a,const vsip_vview_f *b,const vsip_vview_f *r);
%   r =	max(a,b);

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = max(operandA.viewData(),operandB.viewData());

end