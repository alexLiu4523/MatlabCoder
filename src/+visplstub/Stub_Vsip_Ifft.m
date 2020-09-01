function Stub_Vsip_Ifft(inputView, fftNum, resView)
%STUB_VSIP_IFFT

  coder.inline('never');
  resView.assign(ifft(inputView.viewData(), fftNum));

end
