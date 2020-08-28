function [xk, yk, res] = run(a, b)

xn = [a a+1 a+1 a];
xk = matlabstub.Stub_fft(xn, 2);
ah = matlabcoder.MatrixHandle(@() [a;a]);

yn = [b b+1.0 b+1.0 b];
yk = matlabstub.Stub_fft(yn, 2);
bh = matlabcoder.MatrixHandle(@() [b;b]);

res = ah.data(1, 1) + bh.data(1, 1);

end
