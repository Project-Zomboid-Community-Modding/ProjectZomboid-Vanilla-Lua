if debugScenarios == nil then
    debugScenarios = {}
end


debugScenarios.DebugScenarioTGreen = {
    name = "Turbo Green Test",
    world = "Muldraugh, KY",
    startLoc = {x=8496, y=5789, z=0 }, -- other 11989x6903
    setSandbox = function()
        SandboxVars.VehicleEasyUse = true;
        SandboxVars.Zombies = 6;
    end,
    onStart = function()
    end
}