local logfile   = "FTPLog.txt"     -- Where to log output on the FA
local folder    = "/Upload"         -- What folder to upload files from
local server    = "192.168.1.11/"     -- The FTP server's IP
local serverDir = "/Home/pepe/Documentos/python/archivos"               -- The path on the FTP server to use.
local user      = "pepe"             -- FTP username
local passwd    = "kiki123"          -- FTP passwd
--[[
URLs MUST conform to RFC 1738, that is, an URL is a string in the form:
[ftp://][<user>[:<password>]@]<host>[:<port>][/<path>][type=a|i]
--]]

local ftp = require("socket.ftp")
local ltn12 = require("ltn12")
local url = require("socket.url")
local socket = require("socket")
local inspect = require("inspect")

print(socket._VERSION)
print(url._VERSION)

local function list(u)
    local t = {}
    local p = url.parse(u)
    p.command = "nlst"
    p.argument = string.gsub(p.path, "^/", "")
    if p.argument == "" then p.argument = nil end
    p.sink = ltn12.sink.table(t)
    local r, e = ftp.get(p)
    return r and table.concat(t), e
end

local ls = list('ftp://pepe:kiki123@192.168.1.11/')
print(inspect(ls))
