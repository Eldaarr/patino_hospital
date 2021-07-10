Config = {}

------------------------------------------------------------------------------------------------------
------------------------------------------ GENERAL STUFF ---------------------------------------------
------------------------------------------------------------------------------------------------------ 
Config.Language = 'en'
Config.UsingESXLegacy = false -- If you are using ESX Legacy, set this to true and uncomment: '@es_extended/imports.lua' in fxmanifest.lua
Config.ReviveInvoice = 1500
Config.UseRprogress = true -- Disable if you want to revive instantly https://forum.cfx.re/t/release-standalone-rprogress-customisable-radial-progress-bars/1630655
Config.EMSJobName = 'ambulance'
Config.EMSRequired = 3

------------------------------------------------------------------------------------------------------
-------------------------------------------- PED STUFF -----------------------------------------------
------------------------------------------------------------------------------------------------------ 

Config.PedLocations = {
    {x = 319.20547485352, y = -588.57763671875, z = 43.284042358398, h = 149.54759216309} -- Needs heading
 -- {x = 111.13213213122, y = -333.32332455522, z = 43.414144222222, h = 322.32424455551} *Make sure to add a comma ^^^^
}

-- You can find PED MODEL and hash here: https://wiki.rage.mp/index.php?title=Peds
Config.RequestModel = "s_m_m_doctor_01"
-- ^^ (Hash)
Config.PedModel = 0xD47303AC 

------------------------------------------------------------------------------------------------------
------------------------------------------ 3D TEXT STUFF ---------------------------------------------
------------------------------------------------------------------------------------------------------ 
Config.Text = {
    Scale = 0.32,
    Font = 4,
    Distance = 3.5
}

