function Stub_Vsip_SVGt(operandA, operandB, this)
%STUB_VSIP_SVGT
% call function:
%   void (vsip_svlgt_f)(vsip_scalar_f s, const vsip_mview_f* a, const vsip_mview_f* r);
%   r = s > a;

  coder.inline('never');
  thisIndexes = this.matlabIndexes();
  this.dataHandle.data(thisIndexes{:}) = operandA > operandB.viewData();

end

