local t = ...
local strDistId, strDistVersion, strCpuArch = t:get_platform()
local tResult

if strDistId == 'ubuntu' and
strDistVersion == '24.04' and
strCpuArch == 'x86_64' then
  t:install_dev('include',    '${install_dev_include}/')
  t:install_dev('cmake',      '${install_dev_cmake}/')
  tResult = 
end

return tResult 
