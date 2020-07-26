res = MatrixHandleTest();

% handler = zeros(100, 100);
% view = handler(1:2);

handler = matlabcoder.MatrixHandle(zeros(10, 10));
% view = handler(1 : 10, 2);
view = handler.view(1 : 10, 2);