function res = Stub_fft(input, DpcFftNum)
  coder.inline('never');
  res = fft(input, DpcFftNum);
end
