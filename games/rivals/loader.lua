_G.ORBIT_SESSION = _G.ORBIT_SESSION or {
    injected = false,
    teleports = 0
}

local queue_on_teleport = queue_on_teleport or queueonteleport

if queue_on_teleport then
    queue_on_teleport([[
        _G.ORBIT_SESSION = _G.ORBIT_SESSION or {}
        _G.ORBIT_SESSION.teleports = (_G.ORBIT_SESSION.teleports or 0) + 1

        if not _G.ORBIT_SESSION.injected then
            _G.ORBIT_SESSION.injected = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/orbit-sftwks/orbit/refs/heads/main/games/rivals/main.lua"))()
        else
            if _G.ORBIT_ON_TELEPORT then
                pcall(_G.ORBIT_ON_TELEPORT)
            end
        end
    ]])
end

-- Executor support check
local function executor_supported()
    local required = {
        getgc,
        hookfunction,
        getconnections,
        newcclosure,
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
            return false, fn
        end
    end

    return true
end

local supported, missing = executor_supported()
if not supported then
    game:GetService("Players").LocalPlayer:Kick("Orbit: Executor not supported. Missing: " .. tostring(missing))
    return
end

print("========================================")
print("[*] Orbit Loader | Starting...")
print("========================================")

-- Load ACB module
print("[*] Loading ACB module...")
local acb_url = "https://raw.githubusercontent.com/orbit-sftwks/orbit/refs/heads/main/acb.lua"
local acb_success, acb = pcall(function()
    return loadstring(game:HttpGet(acb_url))()
end)

if not acb_success then
    print("[✗] Failed to load ACB module: " .. tostring(acb))
    game:GetService("Players").LocalPlayer:Kick("Orbit: Failed to load ACB module")
    return
end

print("[✓] ACB module loaded")

-- Start ACB
if not acb.start() then
    print("[✗] ACB failed to start")
    game:GetService("Players").LocalPlayer:Kick("Orbit: ACB failed to start")
    return
end

-- Load main script
print("[*] Loading main script...")
local main_url = "https://raw.githubusercontent.com/orbit-sftwks/orbit/refs/heads/main/games/rivals.lua"
local main_script = game:HttpGet(main_url)

-- Finish ACB and load main
if not acb.finished(main_script) then
    print("[✗] ACB completion failed or insufficient bypasses")
    
    if not acb.is_safe() then
        game:GetService("Players").LocalPlayer:Kick("Orbit: Anti-cheat bypass failed - unsafe to proceed")
        return
    end
    
    print("[!] Proceeding with partial bypass - use at your own risk")
    loadstring(main_script)()
end

print("========================================")
print("[✓] Orbit Loader | Complete")
print("========================================")
