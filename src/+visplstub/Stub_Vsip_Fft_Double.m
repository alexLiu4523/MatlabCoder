function Stub_Vsip_Fft_Double(inputView, fftNum, resView)
%STUB_VSIP_FFT_DOUBLE

  resView.assign(fft(inputView.viewData(), fftNum));
end
