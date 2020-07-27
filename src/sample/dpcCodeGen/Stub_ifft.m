function res = Stub_ifft(input, DpcFftNum)
  coder.inline('never');
  res = ifft(input, DpcFftNum);
end