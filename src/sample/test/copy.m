function pfDestData = copy(pfSrcData, pst_testPara)

uiMNum = pst_testPara.uiMNum;
uiNNum = pst_testPara.uiNNum;
uiQNum = pst_testPara.uiQNum;

% #CHANGE
pfDestData = zeros(uiMNum, uiNNum, uiQNum);

for i = 1 : uiQNum * uiNNum  
  pfDestData((i-1)*uiMNum + 1: i*uiMNum) = pfSrcData((i-1)*uiMNum + 1: i*uiMNum);
end

end
