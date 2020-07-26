function [pfDstData]= test(pfSrcData, pfPhaseRandom, ...
  pfBackAmp, pfBuf, pst_testPara)
%��������ά����M*N*Q
%ͨ���pst_testPara��������Ϊ xxx_test_PARA*�� pst_testPara��ָ����Ӧ����֪����
% pst_CorePara�ṹ��ָ��Ϊ��˴����������ⲿ����
%��ں�������Ϊint���ڲ��Ӻ�������Ϊ static int
%
%ͷ�ļ�
%ͷ�ļ��������㷨��h+Ĭ�� xxXBlockViewh��block�󶨷�װ������

% ���� pfSrcData Ϊ��ֵ���;���
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
 