function [pfDstData]= test(pfSrcData, pfPhaseRandom, ...
  pfBackAmp, pfBuf, pst_testPara)
%输入数据维度是M*N*Q
%通用项：pst_testPara数据类型为 xxx_test_PARA*（ pst_testPara内指针项应该已知），
% pst_CorePara结构体指针为多核处理必须项，由外部传入
%入口函数类型为int，内部子函数类型为 static int
%
%头文件
%头文件：功能算法名h+默认 xxXBlockViewh（block绑定封装函数）

% 断言 pfSrcData 为数值类型矩阵
assert(~isscalar(pfSrcData) && isnumeric(pfSrcData))

uiMNum = pst_testPara.uiMNum;
uiIftest = pst_testPara.uiIftest;

if uiIftest == 0
  pfDstData = copy(pfSrcData, pst_testPara);
  return;
end

pfSrcAmp = pfBuf(1 : uiMNum);
piFlag = pfBuf(uiMNum + 1 : 2*uiMNum);
piN_Start = pfBuf(2*uiMNum + 1 : 3*uiMNum);
piN_End = pfBuf(3*uiMNum + 1 : 4*uiMNum);


pfDstData = test_ex(pfSrcData, pfPhaseRandom, pfBackAmp, pfSrcAmp, piFlag, piN_Start, piN_End, pst_testPara);

end
 