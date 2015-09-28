-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
local APW = require("apw/widget")
--require("collision")()
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

-- Load Debian menu entries
require("debian.menu")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init("~/.config/awesome/themes-zen/theme.lua")
beautiful.init("~/.config/awesome/themes/blackburn/theme.lua")
--beautiful.init("~/.config/awesome/themes/multicolor/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e '" .. editor

-- Default apps
function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

awful.util.spawn_with_shell("synapse --startup")
--awful.util.spawn_with_shell("dropbox start")
awful.util.spawn_with_shell("xcompmgr  -CcfF -D2 &")
awful.util.spawn_with_shell("gnome-keyring-daemon --start")
run_once("nm-applet")

if screen.count() == 1 then
--    awful.util.spawn_with_shell("sh /home/fcabrol/.screenlayout/1-screen.sh")
end
if screen.count() == 2 then
--    awful.util.spawn_with_shell("sh /home/fcabrol/.screenlayout/1-external-screens.sh")
end


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle
    --awful.layout.suit.max,
    --awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
tags[1] = awful.tag({ "work 1", "work 2", "work 3", "music", "other" }, 1, layouts[1])
tags[2] = awful.tag({ "work 4" }, 2, layouts[1])
--for s = 1, screen.count() do
    -- Each screen has its own tag table.
    -- tags[s] = awful.tag({ "work 1", "work 2", "work 3", "music", "other" }, s, layouts[1])
--end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e 'man awesome'" },
   { "edit config", editor_cmd .. " " .. awesome.conffile .. "'" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = {
                                    { "Application", debian.menu.Debian_menu.Debian },
                                    { "open terminal", terminal },
                                   { "manual", terminal .. " -e 'man awesome'" },
                                   { "edit config", editor_cmd .. " " .. awesome.conffile .. "'" },
                                   { "restart", awesome.restart },
                                   { "quit", awesome.quit }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mybottombox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

myfocusedtask = {}
myfocusedtask.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

-- Battery widget
-- batterywidget = wibox.widget.textbox()
-- batterywidget:set_text(" | Battery | ")
-- batterywidgettimer = timer({ timeout = 5 })
-- batterywidgettimer:connect_signal("timeout",
--  function()
--    fh = assert(io.popen("acpi | cut -d, -f 2,3 -", "r"))
--    batterywidget:set_text(" |" .. fh:read("*l") .. " | ")
--    fh:close()
--  end
--)
--batterywidgettimer:start()

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- create the focused task widget
    myfocusedtask[s]    = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(APW)
    -- right_layout:add(batterywidget)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(myfocusedtask[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the bottombox
    mybottombox[s] = awful.wibox({ position = "bottom", screen = s })
    local layout2 = wibox.layout.align.horizontal()
    layout2:set_middle(mytasklist[s])
    mybottombox[s]:set_widget(layout2)

end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- next/previous tag
    awful.key({ modkey,  }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,  }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,  }, "h",   awful.tag.viewprev       ),
    awful.key({ modkey,  }, "l",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    -- next/previous client
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "Up",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "Down",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),


    --awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Shift"   }, "Up", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "Down", function () awful.client.swap.byidx( -1)    end),
    -- Focus to next/previous screen
    awful.key({ modkey }, "e", function () awful.screen.focus_relative( 1) end),
    --awful.key({ modkey, "Tab" }, "l", function () awful.screen.focus_relative( 1) end),
    --awful.key({ modkey, "Tab" }, "h", function () awful.screen.focus_relative(-1) end),
    --awful.key({ modkey, "Tab" }, "Right", function () awful.screen.focus_relative( 1) end),
    --awful.key({ modkey, "Tab" }, "Left", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "b", function () awful.util.spawn("google-chrome") end),
    awful.key({ modkey, "Shift"   }, "v", function () awful.util.spawn(editor_cmd .. "'") end),
    awful.key({ modkey, "Shift"   }, "r", function () awful.util.spawn(terminal .. " -e 'ranger'") end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey }, "w", function () awful.util.spawn("gnome-screensaver-command -l") end),


    -- Manage window size
    awful.key({ modkey,  "Shift"     }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,  "Shift"     }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    -- Manage window position
    -- awful.key({ modkey, "Control", "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    -- awful.key({ modkey, "Shift" }, "h",     function () awful.tag.incncol( 1)         end),
    -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Mod1" }, "l",  function () awful.client.moveresize( 0, 0, 40, 0) end),
    awful.key({ modkey, "Mod1" }, "h",  function () awful.client.moveresize( 0, 0, -40, 0) end),
    awful.key({ modkey, "Mod1" }, "j",  function () awful.client.moveresize( 0, 0, 0, -40) end),
    awful.key({ modkey, "Mod1" }, "k",  function () awful.client.moveresize( 0, 0, 0, 40) end),
   awful.key({ modkey, "Control" }, "j",  function () awful.client.moveresize(  0,  -60,   0,   0) end),
   awful.key({ modkey, "Control" }, "k",    function () awful.client.moveresize(  0, 60,   0,   0) end),
   awful.key({ modkey, "Control" }, "h",  function () awful.client.moveresize(-60,   0,   0,   0) end),
   awful.key({ modkey, "Control" }, "l", function () awful.client.moveresize( 60,   0,   0,   0) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),
    awful.key({ modkey }, "s", function ()
        -- If you want to always position the menu on the same place set coordinates
        awful.menu.menu_keys.down = { "Down", "Alt_L" }
        awful.menu:clients({theme = { width = 250 }}, { keygrabber=true, coords={x=525, y=330} })
    end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "v",
        function (c)
            c.maximized_vertical   = not c.maximized_vertical
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, function (c)
        c.maximized_horizontal = false
        c.maximized_vertical   = false
        c.maximized            = false
        c.fullscreen           = false
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c.maximized_horizontal = false
        c.maximized_vertical   = false
        c.maximized            = false
        c.fullscreen           = false
        awful.mouse.client.resize(c)
    end))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "Terminator" },
      properties = { width = 1000, height = 600 } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "wiser-thermostat-hmi" },
      properties = { floating = true , ontop = true, tag = tags[1][1]} },
    { rule = { class = "cairo-dock" },
      properties = { floating = true } },
    { rule = { name = "synapse" },
      properties = { border_width = 0 } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        --right_layout:add(awful.titlebar.widget.floatingbutton(c))
        --right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        --right_layout:add(awful.titlebar.widget.stickybutton(c))
        --right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(right_layout)
        layout:set_right(left_layout)
        layout:set_middle(middle_layout)

        local titlebar_properties = {
            bg_normal = beautiful.titlebar_bg_normal,
            bg_focus = beautiful.titlebar_bg_focus
        }

        awful.titlebar(c, titlebar_properties):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
    c.opacity = 1
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
    c.opacity = 1
end)
-- }}}
