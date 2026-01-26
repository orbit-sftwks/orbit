_G.ORBIT_SESSION = _G.ORBIT_SESSION or {
    injected = false,
    teleports = 0
}

wait(4)
local queue_on_teleport = queue_on_teleport or queueonteleport

if queue_on_teleport then
    queue_on_teleport([[
        _G.ORBIT_SESSION = _G.ORBIT_SESSION or {}
        _G.ORBIT_SESSION.teleports = (_G.ORBIT_SESSION.teleports or 0) + 1

        if not _G.ORBIT_SESSION.injected then
            _G.ORBIT_SESSION.injected = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/orbit-sftwks/orbit/refs/heads/main/games/rivals/loader.lua"))()
        else
            if _G.ORBIT_ON_TELEPORT then
                pcall(_G.ORBIT_ON_TELEPORT)
            end
        end
    ]])
end


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


print("[*] Loading ACB module...")
local acb_url = "https://raw.githubusercontent.com/orbit-sftwks/orbit/refs/heads/main/libraries/acb.lua"
local acb_success, acb = pcall(function()
    return loadstring(game:HttpGet(acb_url))()
end)

if not acb_success then
    print("[✗] Failed to load ACB module: " .. tostring(acb))
    game:GetService("Players").LocalPlayer:Kick("Orbit: Failed to load ACB module")
    return
end

print("[✓] ACB module loaded")


if not acb.start() then
    print("[✗] ACB failed to start")
    game:GetService("Players").LocalPlayer:Kick("Orbit: ACB failed to start")
    return
end


print("[*] Loading main script...")
local main_url = "https://raw.githubusercontent.com/orbit-sftwks/orbit/refs/heads/main/games/rivals/main.lua"
local main_success, main_script = pcall(function()
    return game:HttpGet(main_url)
end)

if not main_success then
    print("[✗] Failed to download main script: " .. tostring(main_script))
    game:GetService("Players").LocalPlayer:Kick("Orbit: Failed to download main script")
    return
end

print("[✓] Main script downloaded")


if not acb.finished() then
    print("[✗] ACB completion check failed")
    
    if not acb.is_safe() then
        game:GetService("Players").LocalPlayer:Kick("Orbit: Anti-cheat bypass failed - unsafe to proceed")
        return
    end
    
    print("[!] Proceeding with partial bypass - use at your own risk")
end


print("[*] Executing main script...")
local exec_success, exec_err = pcall(function()
    loadstring(main_script)()
end)

if not exec_success then
    print("[✗] Failed to execute main script: " .. tostring(exec_err))
    game:GetService("Players").LocalPlayer:Kick("Orbit: Main script execution failed")
    return
end

print("[✓] Main script executed successfully")

print("========================================")
print("[✓] Orbit Loader | Complete")
print("========================================")
