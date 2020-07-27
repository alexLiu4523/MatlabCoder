
%coder.inline('always');
%coder.inline('never');
%coder.inline('default');

m=unidrnd(100);
n=unidrnd(100);
q=unidrnd(100);
SrcData = rand(m,n,q);
DpcCoef = 2;
DpcFftNum = 10;
DpcDelay = 1;
DataLen = 5;
Pulse = 2;
CNum = 2;

data = dpc(SrcData,DpcCoef,DpcFftNum,DpcDelay,DataLen,Pulse,CNum);

matrixTest(rand(5,5));
