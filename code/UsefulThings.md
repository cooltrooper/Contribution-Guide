# Useful Things

## String Functions

### Convert HEX pairs to string

Useful when a device talks in HEX pairs, but for us humans a string is nicer to deal with

```lua
function string.fromhex(str) -- Converts HEX pairs to string
    return (str:gsub('..', function (cc)
        return string.char(tonumber(cc, 16))
    end))
end
```

### Convert Strings to HEX values

Useful when a device talks hex but we dealt with strings

```lua
function string.tohex(str) -- Converts Strings to HEX values
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end
```
### Convert a binary number to a string

```lua
function string.binaryToNum(str) -- Converts a string of binary characters to a number
  return(tonumber(str,2))
end
```

## Number tools

### Number to bits Least significant first
```lua 
function numToBitsLS(num)
  -- returns a table of bits, least significant first.
  local t={} -- will contain the bits
  while num>0 do
      rest=math.fmod(num,2)
      t[#t+1]=rest
      num=(num-rest)/2
  end
  return t
end
```

### Number to bits, most significant fist

```lua
function numToBits(num,bits)
  -- returns a table of bits, most significant first.
  bits = bits or math.max(1, select(2, math.frexp(num)))
  local t = {} -- will contain the bits        
  for b = bits, 1, -1 do
      t[b] = math.fmod(num, 2)
      num = math.floor((num - t[b]) / 2)
  end
  return t
end
```

### Decimal to hexadecimal

```lua
function decimalToHex(num) -- converts a decimal to a hexadecimal value
  local hexstr = '0123456789abcdef'
  local s = ''
  while num > 0 do
      local mod = math.fmod(num, 16)
      s = string.sub(hexstr, mod+1, mod+1) .. s
      num = math.floor(num / 16)
  end
  if s == '' then s = '0' end
  return s
end
```

## Debug tools

### Format strings to show ASCII values in Hex with deliminator

```lua
function ASCII_DEBUG(string) -- Format strings to show ASCII values in Hex with deliminator
  local visual = {}
  for i=1,#string do
    local byte = string:sub(i,i)
    table.insert(visual,string.format("%02X",string.byte(byte)))
  end
  print("ASCII",string,table.concat(visual,"|"))
end
```

### Format strings to show ASCII values in Hex with deliminator using string.tohex

```lua
function ASCII_DEBUG(string) -- Format strings to show ASCII values in Hex with deliminator making use of string.tohex
  local visual = {}
  for i=1,#string do
    local byte = string:sub(i,i)
    table.insert(visual,byte:tohex())
  end
  print("ASCII",string,table.concat(visual,"|"))
end
```

## JSON

### Pretty Printing

> Thanks to Callum Brieske

```lua
json = require("rapidjson") -- Load the RapidJSON Library.
 
query = {
  method = "getSomeThing",
  params = {},
  id = 900,
  version = "1.0"
}
 
print("A vanilla string:\t" .. json.encode(query))
--[[
Output: A vanilla string:   {"id":900,"version":"1.0","params":{},"method":"getSomeThing"}
--]]
print("A 'pretty' string:\r\n" .. json.encode(query, {pretty = true}))
--[[
Output: A 'pretty' string:
{
    "id": 900,
    "version": "1.0",
    "params": {},
    "method": "getSomeThing"
}
--]]
print("A 'pretty' string with the keys sorted:\r\n" .. json.encode(query, {pretty = true, sort_keys = true}))
--[[
Output: A 'pretty' string with the keys sorted:
{
    "id": 900,
    "method": "getSomeThing",
    "params": {},
    "version": "1.0"
}
--]]
print("A 'pretty' string with the keys sorted, and empty tables as arrays:\r\n" .. json.encode(query, {pretty = true, sort_keys = true, empty_table_as_array = true}))
--[[
Output: A 'pretty' string with the keys sorted, and empty tables as arrays:
{
    "id": 900,
    "method": "getSomeThing",
    "params": [],
    "version": "1.0"
}
--]]
```