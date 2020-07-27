function [pfDstData] = test_ex(pfSrcData,pfPhaseRandom,pfBackAmp,pfSrcAmp,piFlag,piN_Start,piN_End,pst_testPara)

uiMNum = pst_testPara.uiMNum;
uiNNum =  pst_testPara.uiNNum;
uiQNum = pst_testPara.uiQNum;
ftestThres = pst_testPara.ftestThres;
uitestWidthThres = pst_testPara.uitestWidthThres;

% #CHANGE
pfDstData = zeros(uiMNum, uiNNum, uiQNum);

for i = 1:uiQNum*uiNNum
    pfNowSrcData = pfSrcData((i-1)*uiMNum+1:i*uiMNum);
    pfNowDstData = pfNowSrcData;
    pfSrcAmp(:) = abs(pfNowSrcData);
    fBackAmp = pfBackAmp(floor((i-1)/uiNNum)+1); % c: i/uiNNum ,matlab:floor(i/uiNNum)
    
    % #CHANGE
    %
    % ԭʼ Matlab :
    % piFlag(:)=pfSrcAmp > ftestThres * fBackAmp;
    % piFlag, pfSrcAmp are vectors of size m, ftestThres and fBackAmp are scalars
    %
    % ԭʼ C :
    % visp_vput_f(pfThresView, 0, ftestThres * fBackAmp);
    % visp_vlgt_f(pfSrcAmpView, pfThresView, pblFlagView);
    % ��������������� pfThresView ������ֵΪ ftestThres * fBackAmp 
    % Ȼ��ʹ���������ڱȽϵó����
    %
    % �� Matlab ʵ�� C ���߼�, ��Ϊ��
    temp1 = ftestThres * fBackAmp; % temp1 is scalar
    vftestThres = zeros(uiMNum);
    Stub_VsipVputDouble(vftestThres, 0, temp1);
    Stub_VsipVlgtDouble(pfSrcAmp, vftestThres, piFlag);
    
    
    [uiDetN_Num,piN_Start(:),piN_End(:)] = testDet(piFlag);
    
    for j = 1:uiDetN_Num
        uiJamWidth = piN_End(j) - piN_Start(j) + 1;
        if uiJamWidth > uitestWidthThres
            continue;
        end
        pfNowPhaseRandom = pfPhaseRandom((i-1)*uiMNum+1:i*uiMNum);
        pfNowDstData(piN_Start(j):piN_End(j))=pfNowPhaseRandom(piN_Start(j):piN_End(j))*fBackAmp;
    end
    
    pfDstData((i-1)*uiMNum+1:i*uiMNum) = pfNowDstData;

end

end
