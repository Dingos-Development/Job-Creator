QBCore = exports['qb-core']:GetCoreObject()

local customJobs = {}

-- Load jobs from the database
function loadJobs()
    local result = MySQL.query.await('SELECT * FROM jobs')
    if result then
        for _, job in pairs(result) do
            customJobs[job.id] = {
                label = job.label,
                grades = {
                    [1] = { salary = job.grade1_salary },
                    [2] = { salary = job.grade2_salary },
                    [3] = { salary = job.grade3_salary },
                    [4] = { salary = job.grade4_salary }
                }
            }
        end

        -- Register jobs in qb-core
        for jobId, jobData in pairs(customJobs) do
            QBCore.Shared.Jobs[jobId] = jobData
        end
    end
end

-- Add new job to the database and register it
RegisterNetEvent('jobcreator:createJob', function(data)
    if not data.name or not data.id or not data.grades then
        return -- Invalid job data
    end

    -- Insert the new job into the database
    MySQL.query.await('INSERT INTO jobs (id, label, grade1_salary, grade2_salary, grade3_salary, grade4_salary) VALUES (?, ?, ?, ?, ?, ?)', {
        data.id, data.name, 
        data.grades[1].salary or 0, 
        data.grades[2].salary or 0, 
        data.grades[3].salary or 0, 
        data.grades[4].salary or 0
    })

    -- Add job to local cache and qb-core
    customJobs[data.id] = {
        label = data.name,
        grades = data.grades
    }
    QBCore.Shared.Jobs[data.id] = customJobs[data.id]
end)

-- Load jobs on resource start
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        loadJobs()
    end
end)
