-- UTF-8 fixture: café / 日本語 / 🌳
local M = {}
local version <const> = "1.0"

local function sum(values, ...)
  local total = 0
  for _, value in ipairs(values) do
    total = total + value
  end
  return total
end

function M.new(name)
  local object = {
    name = name or "anonymous",
    values = {1, 2, 3; ["last"] = 4},
    description = [==[First line
日本語 and ]=] do not close this string
]==],
  }
  return setmetatable(object, {__index = M})
end

function M:total()
  return sum(self.values)
end

return M
