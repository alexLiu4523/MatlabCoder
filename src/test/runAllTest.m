% Note: `.` points to the current folder for MATLAB, not the folder the file locates.
% So if we set `baseFolder` to `.`, the current folder should be `MatlabCoder/src` 
baseFolder = '.'; % 'Y:/ProjsMatlab/MatalbCoder/src';
testBaseFolder = strcat(baseFolder, '/test');
suiteFolder = testsuite(...
    {strcat(testBaseFolder, '/index'),...
     strcat(testBaseFolder, '/MatrixHandle'),...
     strcat(testBaseFolder, '/MatrixView'),...
     strcat(testBaseFolder, '/OperationValue')});
result = run(suiteFolder);
