function DestData = dpc(SrcData,DpcCoef,DpcFftNum,DpcDelay,DataLen,Pulse,CNum)
%³£¹æÂöÑ¹²Ù×÷
% ZerosData = zeros(DpcFftNum-DataLen,1);
ZerosData = matlabcoder.MatrixHandle(matlabcoder.MatrixCreationMethodEnum.Zeros, DpcFftNum-DataLen, 1);
%DestData = zeros(DataLen,Pulse,CNum);
DestDataHandle = matlabcoder.Matrix3DHandle(@() complex(zeros(DataLen,Pulse,CNum)));

for chan = 1:CNum
  for p = 1:Pulse
    temp = [SrcData(:, p, chan); ZerosData.data];
    
    % temp1 = Stub_fft(temp, DpcFftNum);
    temp1Handle = matlabcoder.MatrixHandle(@() Stub_fft(temp, DpcFftNum));
    
    % temp1 = temp1.*DpcCoef;
    temp1Handle.data = (temp1Handle.data).*DpcCoef;
    
    % temp1 = Stub_ifft(temp1,DpcFftNum);
    temp1Handle.data = Stub_ifft(temp1Handle.data, DpcFftNum);
    
    % DestData(:,p,chan) = temp1(DpcDelay+1:DpcDelay+DataLen);
    temp1SubView = temp1Handle.subview(matlabcoder.UnitSpacedIndex(DpcDelay+1, DpcDelay+DataLen)); % temp1(DpcDelay+1:DpcDelay+DataLen)
    % we can direct assign data in handle
    DestDataHandle.data(:,p,chan) = temp1SubView.viewData();
    % or we can use view to assign data£º
    % DestData.subview(matlabcoder.AllIndex.INSTANCE, matlabcoder.SinglePositionIndex.of(p), matlabcoder.SinglePositionIndex.of(chan)).assign(temp1SubView);
  end
end

% Note: Handle Classes in top-level outputs are not supported in MATLAB Coder. Output parameter 'DestData' contains a handle class.
DestData = DestDataHandle.data;

end
