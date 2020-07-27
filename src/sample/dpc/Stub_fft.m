function res = Stub_fft(input, DpcFftNum)
  coder.inline('never');
  res = input + DpcFftNum;
end