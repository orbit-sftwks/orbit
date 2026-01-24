--[[
    ORBIT CONFIG LIBRARY
    Global config saving/loading system
    
    Usage:
        local configlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/orbit-sftwks/orbit/refs/heads/main/libraries/config"))()
        
        -- Save config
        configlib.save("my_config_name", {
            setting1 = true,
            setting2 = 50,
            setting3 = "value"
        })
        
        -- Load config
        local loaded = configlib.load("my_config_name")
        if loaded then
            config.setting1 = loaded.setting1
        end
]]

local configlib = {}

local httpService = game:GetService("HttpService")
local gameId = tostring(game.GameId)

local function getConfigFolder()
    local folder = "orbit_hub_files"
    
    if not isfolder(folder) then
        makefolder(folder)
    end
    
    local gameFolder = folder .. "/" .. gameId
    if not isfolder(gameFolder) then
        makefolder(gameFolder)
    end
    
    return gameFolder
end

local function getConfigPath(configName)
    return getConfigFolder() .. "/" .. configName .. ".json"
end

function configlib.save(configName, configData)
    if not configName or not configData then
        warn("[Config] Invalid parameters for save")
        return false
    end
    
    local success, result = pcall(function()
        local json = httpService:JSONEncode(configData)
        local path = getConfigPath(configName)
        writefile(path, json)
        return true
    end)
    
    if success then
        print("[Config] Saved: " .. configName)
        return true
    else
        warn("[Config] Failed to save: " .. tostring(result))
        return false
    end
end

function configlib.load(configName)
    if not configName then
        warn("[Config] Invalid config name")
        return nil
    end
    
    local path = getConfigPath(configName)
    
    if not isfile(path) then
        warn("[Config] Config not found: " .. configName)
        return nil
    end
    
    local success, result = pcall(function()
        local json = readfile(path)
        return httpService:JSONDecode(json)
    end)
    
    if success then
        print("[Config] Loaded: " .. configName)
        return result
    else
        warn("[Config] Failed to load: " .. tostring(result))
        return nil
    end
end

function configlib.delete(configName)
    if not configName then
        warn("[Config] Invalid config name")
        return false
    end
    
    local path = getConfigPath(configName)
    
    if not isfile(path) then
        warn("[Config] Config not found: " .. configName)
        return false
    end
    
    local success, result = pcall(function()
        delfile(path)
        return true
    end)
    
    if success then
        print("[Config] Deleted: " .. configName)
        return true
    else
        warn("[Config] Failed to delete: " .. tostring(result))
        return false
    end
end

function configlib.list()
    local folder = getConfigFolder()
    local configs = {}
    
    if not isfolder(folder) then
        return configs
    end
    
    local success, files = pcall(function()
        return listfiles(folder)
    end)
    
    if success then
        for _, file in pairs(files) do
            local name = file:match("([^/]+)%.json$")
            if name then
                table.insert(configs, name)
            end
        end
    end
    
    return configs
end

function configlib.exists(configName)
    if not configName then
        return false
    end
    
    local path = getConfigPath(configName)
    return isfile(path)
end

return configlib
