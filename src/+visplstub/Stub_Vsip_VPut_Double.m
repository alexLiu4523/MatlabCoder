function Stub_Vsip_VPut_Double(vectorHandle, value, varargin)
  coder.inline('never');
  
  % Note: varargin is for indexes
  vectorHandle(varargin{1}, varargin{2}) = value;

end
