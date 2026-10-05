--[=[ Long comment containing unmatched-looking { ([ and a ]==] marker. ]=]
local result = 0
for i = 1, 10, 2 do
  if i % 3 == 0 then
    result = result + i
  elseif i > 5 then
    break
  else
    result = result | (i << 1)
  end
end
while result < 100 do result = result * 2 end
repeat result = result - 1 until result < 100

do
  local open <close> = acquire()
  open:write("hello\z  \n world")
end
::finished::
if result == 0 then goto finished end
return result, 0x1.fp+3, 1.5e-2, 2^3^2, "a" .. "b" .. "c"
