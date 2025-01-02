QBCore = exports['qb-core']:GetCoreObject()

local customJobs = {}

-- Load custom jobs from JSON
function loadCustomJobs()
    local file = LoadResourceFile(GetCurrentResourceName(), 'jobs.json')
    if file then
        customJobs = json.decode(file) or {}
    else
        customJobs = {}
    end
end

-- Save custom jobs to JSON
function saveCustomJobs()
    SaveResourceFile(GetCurrentResourceName(), 'jobs.json', json.encode(customJobs, { indent = true }), -1)
end

-- Fetch all jobs (qb-jobs + custom jobs)
RegisterNetEvent('jobcreator:getAllJobs', function()
    local src = source
    local allJobs = QBCore.Shared.Jobs

    for jobId, jobData in pairs(customJobs) do
        allJobs[jobId] = jobData
    end

    TriggerClientEvent('jobcreator:showAllJobs', src, allJobs)
end)

-- Create a new job
RegisterNetEvent('jobcreator:createJob', function(data)
    if not data.name or not data.id or not data.grades then
        return -- Stop execution if data is invalid
    end

    customJobs[data.id] = { label = data.name, grades = data.grades }
    saveCustomJobs()
end)

-- Load jobs on resource start
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        loadCustomJobs()
    end
end)
