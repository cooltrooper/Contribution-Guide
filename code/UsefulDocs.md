# Useful Docs

## Timers

### Call After with anonymous function

Sometimes you want something to happen a moment later. To keep the code local you don't need to define another function. Use an anonymous function.

```lua
Timer.CallAfter(function()
  print("Delayed action")
end,1)
```

## UI

### Setting images on buttons

It is documented that in a plugin in the `GetControls` function you can set an `Icon` property using a base 64 image. It is also possible to set the image at run time.

> Thanks to James Talmage for the code example

```lua
local rapidjson = require("rapidjson")
onImgBase64 = "" --Base 64 image
offImgBase64 = "" --Base 64 image

button.EventHandler = function ()
  local img

  if (button.Boolean) then
    img = onImgBase64
  else
    img = offImgBase64
  end

  button.Legend = rapidjson.encode({
    DrawState = true,
    IconData = img
  })
end
```

### Listbox / Combobox

As per the documentation the following can be done 

```lua
choices = {"Option A", "Option B"} -- an array of strings

Controls.Listbox.Choices = choices

```

The event handler `Controls.Listbox.Choices.EventHandler` `ctl.string` will return a string, e.g. `"Option A"`

It also supports further capabilities:

> Thanks to Andy Pro

```lua
Colour -- text colour
Icon -- per item icon

```

In addition you can add your own variables for use in code

```lua
icons = {
    ['X Circle'] = string.char(0xef,0x88,0x96),
    ['Square'] = string.char(0xe2,0x98,0x90),
}

choices = {
  {
    Text = "Option A",
    Color = "Black",
    Icon = icons["X Circle"],
    Index = 1 -- Custom value for plugin use
  },
  {
    Text = "Option B",
    Color = "Black",
    Icon = icons["Square"],
    Index = 2 -- Custom value for plugin use
  },
} -- an array of strings

Controls.Listbox.Choices = choices
```

The event handler `Controls.Listbox.Choices.EventHandler` `ctl.string` will return a string of an object, e.g. `'{"Text":"Option A","Icon":"","Color":"Black","Index":1}'`

Using the following code you can then interact with the retuend string as a lua object

```lua
Controls.Listbox.EventHandler = function(ctl)
    tmp = json.decode(ctl.String)
    print(tmp["Index"])
end
```

## Radio Buttons

### Type 1 - Code based

```lua
for idx, ctl in ipairs(Controls.MyName) do
    Ctl.EventHandler = function(ev)
        if ev.Boolean == true then
            for i,v in ipairs(Controls.MyName) do
                Ctl.Boolean = i==idx
            end
        --Positive action here
        else
            Contrls.MyName[idx].Boolean = true
        end
    end
end
```

!> Note that this isn't compatible with snapshots.

### Type 2 - Property Based

```lua
for idx, ctl in ipairs(Controls.MyName) do
    Ctl.EventHandler = function(ev)
        for i,v in ipairs(Controls.MyName) do
            Ctl.Boolean = i==idx
        end
        --Positive action here
    end
end
```

You must then set the button properties `Push Action` to `On` in interfaces. This is then supported with snapshots.

> Thanks to Addison Burnside