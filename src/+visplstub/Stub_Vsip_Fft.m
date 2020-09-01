function Stub_Vsip_Fft(inputView, fftNum, resView)
%STUB_VSIP_FFT

  coder.inline('never');
  resView.assign(fft(inputView.viewData(), fftNum));

end
