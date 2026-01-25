-- ORBIT CONFIG LIBRARY (SMART PIPELINE VERSION)

local configlib = {}

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local gameId = tostring(game.GameId)

-- executor capability check
local function executor_supported()
    local required = {
        writefile,
        readfile,
        isfile,
        isfolder,
        makefolder,
        delfile,
        listfiles
    }

    for _, fn in ipairs(required) do
        if type(fn) ~= "function" then
            return false
        end
    end

    return true
end

-- block hard if unsupported
if not executor_supported() then
    LocalPlayer:Kick("Orbit: Executor does not support filesystem API.")
    return
end

local function getConfigFolder()
    local root = "orbit_hub_files"
    if not isfolder(root) then
        makefolder(root)
    end

    local gameFolder = root .. "/" .. gameId
    if not isfolder(gameFolder) then
        makefolder(gameFolder)
    end

    return gameFolder
end

local function getConfigPath(name)
    return getConfigFolder() .. "/" .. name .. ".json"
end

-- waits for filesystem to be fully usable (important for some executors)
function configlib.wait_for_pipeline(timeout)
    timeout = timeout or 5
    local start = os.clock()

    while os.clock() - start < timeout do
        local ok = pcall(function()
            local path = getConfigPath("__test")
            writefile(path, "{}")
            delfile(path)
        end)

        if ok then
            return true
        end

        task.wait(0.1)
    end

    return false
end

function configlib.save(name, data)
    if not name or type(data) ~= "table" then
        warn("[Config] Invalid save request")
        return false
    end

    local ok, err = pcall(function()
        writefile(getConfigPath(name), HttpService:JSONEncode(data))
    end)

    if not ok then
        warn("[Config] Save failed:", err)
        return false
    end

    return true
end

function configlib.load(name)
    if not name then return nil end

    local path = getConfigPath(name)
    if not isfile(path) then
        return nil
    end

    local ok, result = pcall(function()
        return HttpService:JSONDecode(readfile(path))
    end)

    if ok then
        return result
    end

    warn("[Config] Load failed:", result)
    return nil
end

function configlib.exists(name)
    return name and isfile(getConfigPath(name)) or false
end

function configlib.list()
    local folder = getConfigFolder()
    local out = {}

    for _, file in ipairs(listfiles(folder)) do
        local name = file:match("([^/]+)%.json$")
        if name then
            table.insert(out, name)
        end
    end

    return out
end

return configlib
