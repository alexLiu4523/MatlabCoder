function res = Stub_ifft(input, DpcFftNum)
  coder.inline('never');
  res = input + DpcFftNum;
end