local callbacks = {
  function(x) return x * x end,
  function(x, ...) return select("#", ...), x end,
}
function app.worker:run(input)
  self.handlers[1](input)
  factory().target = input
  return (callbacks[1])(input), require "module", consume {ready = true}
end
