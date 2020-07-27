function DestData = dpcWithExtrinsic(SrcData,DpcCoef,DpcFftNum,DpcDelay,DataLen,Pulse,CNum)
%³£¹æÂöÑ¹²Ù×÷
ZerosData = zeros(DpcFftNum-DataLen,1);
DestData = zeros(DataLen,Pulse,CNum);

coder.extrinsic('Mock_fft', 'Mock_ifft'); 
for chan = 1:CNum
    for p = 1:Pulse
        temp = [SrcData(:,p,chan);ZerosData];
        temp1 = temp;
        temp1 = Mock_fft(temp,DpcFftNum); % fft(temp,DpcFftNum);
        temp1 = temp1.*DpcCoef;
        temp1 = Mock_ifft(temp1,DpcFftNum); % ifft(temp1,DpcFftNum);
        DestData(:,p,chan) = temp1(DpcDelay+1:DpcDelay+DataLen);
    end
end

end