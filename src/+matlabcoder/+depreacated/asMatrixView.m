function res = asMatrixView(handle, index1, index2)
coder.inline('never');
res = handle.data(index1, index2);
end
