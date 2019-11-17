_ENV = require('Lunity.lunity')()

function test:foo()
  assertTrue(42 == 40 + 2)
  assertFalse(42 == 40)
  assertEqual(42, 42)
  assertNotEqual(42, 40, "These better not be the same!")
  assertTableEquals({ a=42 }, { ["a"]=6*7 })
  -- See below for more assertions available
end

test()