#!/usr/local/bin/lua
--[[
  udreportcnv.lua - UltraDefrag report converter.
  Converts lua reports to HTML and other formats.
  Copyright (c) 2008-2013 Dmitri Arkhangelski (dmitriar@gmail.com).

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.
 
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
--]]

usage = [[
USAGE: lua udreportcnv.lua {path to Lua Report} {UltraDefrag installation directory} [-v]
]]

-------------------------------------------------------------------------------
-- Localization Strings
-------------------------------------------------------------------------------

FRAGMENTED_FILES_ON = "Fragmented files on"
VISIT_HOMEPAGE      = "Visit our Homepage"
VIEW_REPORT_OPTIONS = "View report options"
POWERED_BY_LUA      = "Powered by Lua"
FRAGMENTS           = "Fragments"
SIZE                = "Size"
FILENAME            = "Filename"
COMMENT             = "Comment"
STATUS              = "Status"
LOCKED              = "locked"
MOVE_FAILED         = "move failed"
INVALID             = "invalid"

-------------------------------------------------------------------------------
-- Auxiliary Procedures
-------------------------------------------------------------------------------

-- converts number of bytes to a human readable format
function hrsize(n)
    local suffixes = {"B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"}
    local i = 1
    while n >= 1024 do
        n = n / 1024
        i = i + 1
    end
    -- round up
    local m = math.floor(n)
    if n >= (m + 0.5) then m = m + 1 end
    return m .. " " .. suffixes[i]
end

-- writes path to the file, splitted when requested
function write_file_path(path,f)
    local split = false
    if split_long_names ~= 1 then
    elseif max_chars_per_line == nil then
    elseif max_chars_per_line == 0 then
    elseif string.len(path) <= max_chars_per_line then
    else split = true
    end
    if not split then
        f:write(path)
        return
    end
    -- split long lines
    local parts, part, seq = {}, {}, ""
    for c in string.gfind(path,"(.)") do
        local b = string.byte(c)
        if b < 0x80 then
            -- single byte sequence
            if string.len(seq) ~= 0 then
                table.insert(part,seq)
                seq = ""
            end
            table.insert(part,c)
        elseif b < 0xC2 then
            -- 2-nd or 3-rd byte of multibyte sequence
            seq = seq .. c
        else
            -- 1-st byte of multibyte sequence
            if string.len(seq) ~= 0 then
                table.insert(part,seq)
            end
            seq = c
        end
        if b == 0x5C then -- back slash
            table.insert(parts,part)
            part = {}
        end
    end
    if string.len(seq) ~= 0 then
        table.insert(part,seq)
    end
    table.insert(parts,part)
    local chars_to_write = max_chars_per_line
    local break_at_end = false
    for j, part in ipairs(parts) do
        local part_len = table.maxn(part)
        if part_len == 0 then break end
        if part_len > chars_to_write then
            if j ~= 1 and not break_at_end then
                f:write("<br>"); break_at_end = true
                chars_to_write = max_chars_per_line
            end
        end
        if part_len <= chars_to_write then
            for k, seq in ipairs(part) do
                f:write(seq); break_at_end = false
            end
            chars_to_write = chars_to_write - part_len
        else -- current part is too long
            for k, seq in ipairs(part) do
                f:write(seq); break_at_end = false
                chars_to_write = chars_to_write - 1
                if chars_to_write == 0 then
                    f:write("<br>"); break_at_end = true
                    chars_to_write = max_chars_per_line
                end
            end
        end
    end
end

function display_report(path)
    local ret, msg
    if os.shellexec then
        ret, msg = os.shellexec(path,"open")
        if ret <= 32 then error(msg) end
    else
        if os.execute("cmd.exe /C " .. path) ~= 0 then
            error("Cannot execute cmd.exe /C " .. path .. " command!")
        end
    end
end

-------------------------------------------------------------------------------
-- Internationalization Procedures
-------------------------------------------------------------------------------

function get_localization_strings()
    local BOM = string.char(0xEF,0xBB,0xBF)
    
    f = io.open(instdir .. "\\reports.lng","r")
    if not f then return end
    for line in f:lines() do
        local pair, key, value
        i, j, pair = string.find(line,string.format("^%s(.-)$",BOM))
        if not pair then pair = line end
        i, j, key, value = string.find(pair,"^%s*(.-)%s*=%s*(.-)%s*$")
        if key and value then
            if _G[key] then _G[key] = string.gsub(value,"\\n","\n") end
        end
    end
    f:close()
end

-------------------------------------------------------------------------------
-- Plain Text Output Procedures
-------------------------------------------------------------------------------

-- Plain text reports can be used in batch scripts to extract
-- information from. So, let's avoid their localization.

function write_text_header(f)
    local compname, formatted_time = "", ""
    
    if computer_name then
        compname = computer_name .. ': '
    end
    
    -- format time appropriate for locale
    if current_time then
        formatted_time = os.date("%c",os.time(current_time))
    end
    
    -- write byte order mark
    f:write(string.char(0xEF,0xBB,0xBF))

    f:write(";---------------------------------------------------------------------------------------------\n")
    f:write("; ", compname, "Fragmented files on ", volume_letter, ": [", formatted_time, "]\n;\n")
    f:write("; Fragments    Filesize  Comment      Status    Filename\n")
    f:write(";---------------------------------------------------------------------------------------------\n")
    f:write("\n")
end

function write_main_table(f)
    for i, file in ipairs(files) do
        f:write(string.format("%11u%12s%9s%12s    ",
            file.fragments, 
            hrsize(file.size),
            file.comment,
            file.status)
        )
        f:write(string.gsub(file.path,"/","\\"),"\n")
    end
end

function build_text_report()
    local filename = string.gsub(report_path,"%.luar$","%.txt")
    local f = assert(io.open(filename,"w"))
    write_text_header(f)
    write_main_table(f)
    f:close()
    return filename
end

-------------------------------------------------------------------------------
-- HTML Output Procedures
-------------------------------------------------------------------------------

-- HTML reports are intended to be opened in a web
-- browser. So, let's use localized strings there.

-- these markups must be identical, except of representation
table_head        = [[<table id="main_table" border="1" cellspacing="0" width="100%">]]
table_head_for_js = [[<table id=\"main_table\" border=\"1\" cellspacing=\"0\" width=\"100%%\">]]

js, css = "", ""
formatted_time = ""

header = [[
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>$compname$FRAGMENTED_FILES_ON $volume_letter: [$formatted_time]</title>
    <style type="text/css">
      $css
    </style>
    <script language="javascript">
      $js
    </script>
  </head>
  <body>
    <h3 class="title">$compname$FRAGMENTED_FILES_ON $volume_letter: ($formatted_time)</h3>
    <div id="for_msie">
      $table_head
      <tr>
        <td class="c"><a href="javascript:sort_items('fragments')">$FRAGMENTS</a></td>
        <td class="c"><a href="javascript:sort_items('size')">$SIZE</a></td>
        <td class="c"><a href="javascript:sort_items('name')">$FILENAME</a></td>
        <td class="c"><a href="javascript:sort_items('comment')">$COMMENT</a></td>
        <td class="c"><a href="javascript:sort_items('status')">$STATUS</a></td>
      </tr>
]]

footer = [[
      </table>
    </div>
    <table class="links_toolbar" width="100%"><tbody>
      <tr>
        <td class="left"><a href="http://ultradefrag.sourceforge.net">$VISIT_HOMEPAGE</a></td>
        <td class="center"><a href="file:///$instdir_utf8\options.lua">$VIEW_REPORT_OPTIONS</a></td>
        <td class="right"><a href="http://www.lua.org/">$POWERED_BY_LUA</a></td>
      </tr>
    </tbody></table>
    <script type="text/javascript">init_sorting_engine();</script>
  </body>
</html>
]]

function expand (s)
  s = string.gsub(s, "$([%w_]+)", function (n)
        return tostring(_G[n])
      end)
  return s
end

function write_file_status(f,file)
    if file.status == "locked" then
        f:write(LOCKED)
    elseif file.status == "move failed" then
        f:write(MOVE_FAILED)
    elseif file.status == "invalid" then
        f:write(INVALID)
    else
        f:write(file.status)
    end
end

function write_main_table_body(f)
    for i, file in ipairs(files) do
        f:write("<tr class=\"u\">",
            "<td class=\"c\">",file.fragments,"</td>",
            "<td class=\"filesize\" id=\"", file.size, "\">",
            string.gsub(hrsize(file.size)," ","&nbsp;"),"</td>"
        )
        f:write("<td>")
        write_file_path(string.gsub(file.path,"/","\\"),f)
        f:write("</td>")
        f:write("<td class=\"c\">", file.comment, "</td>")
        f:write("<td class=\"file-status\">")
        write_file_status(f,file)
        f:write("</td></tr>\n")
    end
end

function get_javascript()
    local js = ""
    if(enable_sorting == 1) then
        -- read udsorting.js file contents
        local f = assert(io.open(instdir .. "\\scripts\\udsorting.js", "r"))
        js = f:read("*all")
        if not js then js = "" end
        f:close()
    end
    if js == "" then
        js = "function init_sorting_engine(){}\nfunction sort_items(criteria){}\n"
    end

    -- replace $TABLE_HEAD by actual markup
    return string.gsub(js,"$TABLE_HEAD",table_head_for_js)
end

function get_css()
    -- read udreport.css file contents
    local f = assert(io.open(instdir .. "\\scripts\\udreport.css", "r"))
    local css = f:read("*all")
    if not css then css = "" end
    f:close()

    -- read udreport-custom.css file contents
    local custom_css = ""
    f = io.open(instdir .. "\\scripts\\udreport-custom.css", "r")
    if f then
        custom_css = f:read("*all")
        if not custom_css then custom_css = "" end
        f:close()
    end

    return (css .. custom_css)
end

function build_html_report()
    local filename = string.gsub(report_path,"%.luar$","%.html")
    local f = assert(io.open(filename,"w"))

    -- get JavaScript and CSS
    js = get_javascript()
    css = get_css()
    
    if computer_name then
        compname = computer_name .. ': '
    else
        compname = ""
    end
    
    -- format time appropriate for locale
    if current_time then
        formatted_time = os.date("%c",os.time(current_time))
    end

    f:write(expand(header))
    write_main_table_body(f)
    f:write(expand(footer))

    f:close()
    return filename
end

-------------------------------------------------------------------------------
-- Main Code
-------------------------------------------------------------------------------
report_path = arg[1]
instdir     = arg[2]

instdir_utf8 = os.getenv("UD_INSTALL_DIR")
if not instdir_utf8 then instdir_utf8 = instdir end

assert(report_path, usage)
assert(instdir, usage)

-- get report options
dofile(instdir .. "\\options.lua")

-- read source file
dofile(report_path)

error_msg = [[
Reports produced by old versions of UltraDefrag
are no more supported. Run the disk analysis again.
]]

-- check the report format version
if format_version == nil or format_version < 7 then
    error(error_msg)
end

-- read i18n strings
get_localization_strings()

-- build file fragmentation reports
if produce_html_report == 1 then
    html_report_path = build_html_report()
end
if produce_plain_text_report == 1 then
    text_report_path = build_text_report()
end

-- display report if requested
if arg[3] == "-v" then
    if produce_html_report == 1 then
        display_report(html_report_path)
    elseif produce_plain_text_report == 1 then
        display_report(text_report_path)
    end
end
