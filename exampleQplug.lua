-- Plugin Name
-- Plugin Author
-- Plugin Source Link
-- ©LICENSE IF REQUIRED
local plugName = "PluginName" -- utility for code availability
local plugGroup = "PluginGroup"
local authorName = "GroupName" -- Utility for code availability
local plugVersion = "0.0.1" -- Semantic versioning!

PluginInfo = {
    Name = authorName .. "~" .. plugGroup .. "~" .. plugName .. " v" ..
        plugVersion,
    Version = plugVersion,
    Id = "", -- Unique ID guidgenerator.com
    Description = "", -- Description used when prompting for plugin install/update
    ShowDebug = true, -- Shows the debug panel under the plugin
    Author = authorName
}

---Return the default block colour in Designer
---@param props table Designer properties
---@return table {r,g,b}
function GetColor(props) return {0, 83, 190} end

-- Plugin Pretty Name, shown in the properties panel and on the block
---@param props table Desiner properties
---@return string -- name
function GetPrettyName(props)
    return authorName .. " " .. plugName .. " v" .. plugVersion
end

---Sets the designer properties
-- Example Object:
-- {
--   Name    = "MyProperty",                         <- text displayed next to property and referred to as 'props["<property_name>"].Value' in the code.
--   Type    = "string|integer|double|boolean|enum", <- Property type. (boolean will show as yes/no but evaluate as true/false in code)
--   Value   = "",                                   <- default value for property (in correct type for property)
--   Choices = {"c1","c2","c3"},                     <- for enum types a list of choices
--   Min     = integer,                              <- lowest value for integer and double types
--   Max     = integer,                              <- highest value for integer and double types
-- }
---@return table props
function GetProperties()
    local props = {
        {Name = "MyStringProperty", Type = "string", Value = "Hello World"},
        {
            Name = "MyIntegerProperty",
            Type = "integer",
            Min = 2,
            Max = 10,
            Value = 5
        }, {Name = "MyBooleanProperty", Type = "boolean", Value = false}, {
            Name = "MyEnumProperty",
            Type = "enum",
            Choices = {"Value 1", "Value 2", "Value 3"},
            Value = "Value 1"
        }
    }
    return props
end

--- Rectify Properties
--- Used to hide the properties that can be hidden based on other propery settings.
--- eg -> props["Number of PINs"].IsHidden = props["Use PIN"].Value == "No" <-- .IsHidden will hide a property line if set to "Yes"
---@param props table Designer properties
---@return table props modified properties table
function RectifyProperties(props) return props end

--- Return a list of controls for the plugin. You can do this statically or dynamically, just return the table at the end.
--- Example object:
--- {
---   Name          = "myControl",                                        <- Name used for control, used on pins, within the script and QRC.
---   ControlType   = "Button|Knob|Indicator|Text",
---   ControlUnit   = "dB|Hz|Float|Integer|Pan|Percent|Position|Seconds", <- Used for knob controls
---   Min           = integer,                                            <- Used for knob controls
---   Max           = integer,                                            <- Used for knob controls
---   ButtonType    = "Toggle|Momentary|Trigger",                         <- Used for button control type
---   IndicatorType = "Led|Meter|Text|Status",                            <- Used for indicator control type
---   Count         = integer,                                            <- The number of controls
---   PinStyle      = "Input|Output|Both",                                <- Expose pins on the plugin
---   UserPin       = boolean,                                            <- Can the user toggle on/off the pin. If false the pin will always be visible
---   IconType      = "SVG|Image|Icon",                                   <- Image can be PNG with alpha or Jpeg. Icon is built in icons
---   Icon          = "",                                                 <- Base 64 encoded string https://www.base64-image.de/. For built in icons, use the designer string, e.g. "Play"
--- }
---@param props table Designer properties
---@return table ctls
function GetControls(props)
    -- Statically define controls
    local ctls = {
        -- ControlType == Indicator
        {
            Name = "IndicatorLed",
            ControlType = "Indicator",
            IndicatorType = "Led",
            PinStyle = "Output",
            UserPin = true
        }, {
            Name = "IndicatorMeter",
            ControlType = "Indicator",
            IndicatorType = "Meter",
            PinStyle = "Output",
            UserPin = true
        }, {
            Name = "IndicatorText",
            ControlType = "Indicator",
            IndicatorType = "Text",
            PinStyle = "Output",
            UserPin = true
        }, {
            Name = "IndicatorStatus",
            ControlType = "Indicator",
            IndicatorType = "Status",
            PinStyle = "Output",
            UserPin = true
        }, -- ControlType == Button
        {
            Name = "ButtonMomentary",
            ControlType = "Button",
            ButtonType = "Toggle",
            PinStyle = "Input",
            Count = 1,
            UserPin = true
        }, {
            Name = "ButtonToggle",
            ControlType = "Button",
            ButtonType = "Toggle",
            PinStyle = "Input",
            Count = 1,
            UserPin = true
        }, {
            Name = "ButtonTrigger",
            ControlType = "Button",
            ButtonType = "Trigger",
            PinStyle = "Input",
            Count = 1,
            UserPin = true
        }, -- ControlType == Knob
        {
            Name = "KnobHz",
            ControlType = "Knob",
            ControlUnit = "Hz",
            PinStyle = "Output",
            Count = 1,
            UserPin = true
        }, {
            Name = "KnobFloat",
            ControlType = "Knob",
            ControlUnit = "Float",
            PinStyle = "Output",
            Count = 1,
            UserPin = true
        }, {
            Name = "KnobInteger",
            ControlType = "Knob",
            ControlUnit = "Integer",
            PinStyle = "Output",
            Count = 1,
            UserPin = true
        }, {
            Name = "KnobPan",
            ControlType = "Knob",
            ControlUnit = "Pan",
            PinStyle = "Output",
            Count = 1,
            UserPin = true
        }, {
            Name = "KnobPercent",
            ControlType = "Knob",
            ControlUnit = "Percent",
            PinStyle = "Output",
            Count = 1,
            UserPin = true
        }, {
            Name = "KnobPosition",
            ControlType = "Knob",
            ControlUnit = "Position",
            PinStyle = "Output",
            Count = 1,
            UserPin = true
        }, {
            Name = "KnobSeconds",
            ControlType = "Knob",
            ControlUnit = "Seconds",
            PinStyle = "Output",
            Count = 1,
            UserPin = true
        }
    }
    -- Dynamically insert controls
    for i = 1, props.MyIntegerProperty.Value do
        table.insert(ctls, {
            Name = "Special Control" .. i,
            ControlType = "Knob",
            ControlUnit = "Seconds",
            PinStyle = "Output",
            Count = 1,
            UserPin = false
        })
    end
    return ctls
end

-- Variable holding Page Names for ease
---@type table<interger,string>
local pageNames = {"Page 1", "Page 2"}

-- Returns the pages, comment out if only using a single page.
---@return table pages 
function GetPages()
    local pages = {}
    for ix, name in ipairs(pageNames) do
        table.insert(pages, {name = pageNames[ix]})
    end
    return pages
end

-- This function allows you to layout controls in your plugin in your plugin.
-- Z-Order is determined by the order graphics are defined (lower to upper; upper covers lower)
-- Control object:
-- layout["myControl"] = { <- Control name, must match that defined in GetControls. For multiple controls use ["myControl "..i] in a loop.
-- PrettyName       = "Group~The Best Control",                                     <- User facing control name.
-- Style            = "Fader|Knob|Button|Text|Meter|Led|ListBox|ComboBox|Html|None",<- None allows you to have a control pin but nothing on the UI
-- Position         = {x,y},                                                        <- Position on screen
-- Size             = {x,y},                                                        <-Size of control
-- Color            = {r,g,b}|"#RRGGBBAA",                                          <- Control colour
-- UnlinkOffColor   = true|false,
-- OffColor         = {r,g,b}|"#RRGGBBAA",                                          <- Control off colour
-- BackgroundColor  = {r,g,b },                                                     <- For Meters
-- ButtonStyle      = "Toggle|Momentary|Trigger|On"Off"Custom",                     <- Custom is for string buttons
-- CustomButtonUp   = "",                                                           <- String value for custom button
-- CustomButtonDown = "",                                                           <- String value for custom button
-- Legend           = "",                                                           <- Button Legend, can also be changed at runtime
-- MeterStyle       = "Level|Reduction|Gain|Standard",                              <- Meter Style
-- ShowTextBox      = boolean                                                       <- for meters, fader and knobs
-- TextBoxStyle     = "Normal|Meter|NoBackground",
-- HTextAlign       = "Center|Left|Right",
-- VTextAlign       = "Center|Top|Bottom",
-- WordWrap         = boolean,
-- Padding          = integer,
-- Margin           = integer,
-- Font             = string,                                                       <- see designer options for values
-- FontStyle        = string,                                                       <- see designer for valid option for chosen font
-- FontSize         = integer,
-- StrokeColor      = {r,g,b},
-- StrokeWidth      = integer,
-- CornerRadius     = integer,
-- IsReadOnly       = boolean,                                                      <- Cannot be changed at runtime. Not required for indicators.
-- ButtonVisualStyle = "",                                                          <- "Flat"|"Gloss"
-- }
-- Graphics object:
-- {
--   Type         = "Label|Groupbox|Header|MeterLegend|Image|SVG",
--   Image        = "",                                            <- Base 64 encoded image. Without a size PNG/JPG images scale to the original size.
--   Position     = {x,y},
--   Size         = {x,y},
--   Text         = string,
--   Font         = string,                                        <- see designer options for values
--   FontStyle    = string,                                        <- see designer for valid option for chosen font
--   FontSize     = integer,
--   HTextAlign   = "Center|Left|Right",
--   VTextAlign   = "Center|Top|Bottom",
--   Color        = {r,g,b}|"#RRGGBBAA",
--   TextColor    = {r,g,b},                                       <- For Label types use Color
--   StrokeColor  = {r,g,b},                                       <- color of the outline (GroupBox and Label only)
--   Fill         = {r,g,b},                                       <- color inside the outline (GroupBox only)
--   StrokeWidth  = integer
--   CornerRadius = integer
-- }
---@param props table Designer properties
---@return table layout layout of all controlls
---@return table graphics layout of all graphics
function GetControlLayout(props)
    -- layout holds Controls
    ---@type table<string,table>
    local layout = {}
    -- graphics holds aesthetic & design items
    ---@type table<string,table>
    local graphics = {}
    -- ctl_str is a helper string to get around system not indexing single value as [1]
    -- local ctl_str = tostring(props["SomeValue"].Value == 1 and "" or " " .. PageIndex)

    -- How to use pages if defined
    local CurrentPage = pageNames[props["page_index"].Value] -- utility for page names

    if CurrentPage == "Page 1" then
        -- items added in here, controls or graphics will only be displayed on page 1
    elseif CurrentPage == "Page 2" then
        -- items added in here, controls or graphics will only be displayed on page 2
    end
    -- items outside if statement will be displayed on all pages.

    -- Basic graphic layout example:
    local x, y = 0, 0 -- x,y allows an easy method of knowing where you are relative to the section being designed

    --- Local colour refence
    ---@type table<sting,table>
    local Colors = {White = {255, 255, 255}, Black = {0, 0, 0}}

    table.insert(graphics, {
        Type = "GroupBox", -- This is the overall groupbox that will give the plugin a more 'contained' look
        Text = authorName .. " " .. plugName .. " v" .. plugVersion,
        HTextAlign = "Left",
        Fill = Colors.White,
        CornerRadius = 8,
        StrokeColor = Colors.Black,
        StrokeWidth = 1,
        Position = {x, y},
        Size = {220, 140}
    })
    table.insert(graphics, {
        Type = "Text",
        Text = "My Text Field",
        Font = "Roboto",
        FontSize = 12,
        FontStyle = "Bold",
        HTextAlign = "Left",
        Color = Colors.Black,
        Position = {x + 5, y + 20},
        Size = {100, 20}
    })
    -- Buttons Section
    y = y + 150
    table.insert(graphics, {
        Type = "GroupBox",
        Text = "Button Elements",
        HTextAlign = "Left",
        Fill = Colors.White,
        CornerRadius = 8,
        StrokeColor = Colors.Black,
        StrokeWidth = 1,
        Position = {x, y},
        Size = {220, 140}
    })
    -- Indicator Section
    y = y + 150
    table.insert(graphics, {
        Type = "GroupBox",
        Text = "Indicator Elements",
        HTextAlign = "Left",
        Fill = Colors.White,
        CornerRadius = 8,
        StrokeColor = Colors.Black,
        StrokeWidth = 1,
        Position = {x, y},
        Size = {220, 140}
    })
    -- Knob Section
    y = y + 150
    table.insert(graphics, {
        Type = "GroupBox",
        Text = "Knob Elements",
        HTextAlign = "Left",
        Fill = Colors.White,
        CornerRadius = 8,
        StrokeColor = Colors.Black,
        StrokeWidth = 1,
        Position = {x, y},
        Size = {220, 140}
    })

    return layout, graphics
end

-- Construct Input and Outpins and their labels
---@param props table Designer properties
---@return table pins Table of pins
function GetPins(props)
    local ch_count = props["Channel Count"].Value
    local pins = {}

    for i = 1, ch_count do
        table.insert(pins,
                     {Name = string.format("Input %i", i), Direction = "input"})
        table.insert(pins, {
            Name = string.format("Output %i", i),
            Direction = "output"
        })
    end
    return pins
end

-- Construct Internal components
---@param props table Designer properties
---@return table comps Components
function GetComponents(props)
    local ch_count = props["Channel Count"].Value
    local comps = {
        {
            Name = "internal_gain",
            Type = "gain",
            Properties = {
                multi_channel_type = 3, -- set multichannel type
                multi_channel_count = ch_count -- match channel count
            }
        }, {
            Name = "internal_stepper",
            Type = "stepper",
            Properties = {
                control_type = 2, -- // Integer
                num_steps = 100
            }
        }
    }

    return comps
end

-- Map I/O pins to Internal component wiring
---@param props table Designer properties
---@return table wiring Internal wiring
function GetWiring(props)
    local ch_count = props["Channel Count"].Value
    local wiring = {}

    for i = 1, ch_count do
        table.insert(wiring, {
            string.format("Input %i", i),
            string.format("internal_gain Input Channel %i", i)
        })
        table.insert(wiring, {
            string.format("internal_gain Output Channel %i", i),
            string.format("Output %i", i)
        })
    end

    return wiring
end

if Controls then
    -- Main code lives here
    -- Access plugin controls with "Controls." as you would in text controller
end
