QBCore = exports['qb-core']:GetCoreObject()

local jobs = {}

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        LoadJobs()
    end
end)

RegisterNetEvent('jobcreator:getJobs', function()
    local src = source
    TriggerClientEvent('jobcreator:receiveJobs', src, jobs)
end)

RegisterNetEvent('jobcreator:createJob', function(data)
    local src = source

    if not data.id or not data.label then
        TriggerClientEvent('QBCore:Notify', src, 'Invalid job data.', 'error')
        return
    end

    -- Add job to the selected system
    if Config.JobSystem == "ps-multijob" then
        exports['ps-multijob']:AddJob(data.id, data.label)
    elseif Config.JobSystem == "qb-jobs" then
        QBCore.Shared.Jobs[data.id] = { label = data.label, grades = {} }
    end

    -- Add to jobs table
    jobs[data.id] = {
        label = data.label,
        grades = {
            [1] = { salary = 0 },
            [2] = { salary = 0 },
            [3] = { salary = 0 },
            [4] = { salary = 0 }
        }
    }

    SaveJobs()
    TriggerClientEvent('QBCore:Notify', src, 'Job created successfully.', 'success')
end)

RegisterNetEvent('jobcreator:setGradeSalary', function(data)
    local src = source

    if not data.id or not data.grade or not data.salary then
        TriggerClientEvent('QBCore:Notify', src, 'Invalid grade data.', 'error')
        return
    end

    if jobs[data.id] and jobs[data.id].grades[data.grade] then
        jobs[data.id].grades[data.grade].salary = data.salary

        -- Add billing functionality based on selected system
        if Config.BillingSystem == "okokBilling" then
            exports['okokBilling']:CreateBill(src, jobs[data.id].label, 'Salary Adjustment (Grade ' .. data.grade .. ')', data.salary)
        elseif Config.BillingSystem == "qb-banking" then
            local Player = QBCore.Functions.GetPlayer(src)
            Player.Functions.RemoveMoney("bank", data.salary, "Salary Adjustment")
        end

        SaveJobs()
        TriggerClientEvent('QBCore:Notify', src, 'Salary updated successfully.', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Job or grade not found.', 'error')
    end
end)

function SaveJobs()
    SaveResourceFile(GetCurrentResourceName(), 'jobs.json', json.encode(jobs, { indent = true }), -1)
end

function LoadJobs()
    local file = LoadResourceFile(GetCurrentResourceName(), 'jobs.json')
    if file then
        jobs = json.decode(file) or {}
        print("[JobCreator] Jobs loaded successfully!")
    else
        jobs = {}
        print("[JobCreator] No jobs found, starting fresh.")
    end
end

-- ██████╗ ██╗███╗   ██╗ ██████╗  ██████╗ ███████╗
-- ██╔══██╗██║████╗  ██║██╔════╝ ██╔═══██╗██╔════╝
-- ██║  ██║██║██╔██╗ ██║██║  ███╗██║   ██║███████╗
-- ██║  ██║██║██║╚██╗██║██║   ██║██║   ██║╚════██║
-- ██████╔╝██║██║ ╚████║╚██████╔╝╚██████╔╝███████║
-- ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═════╝ ╚══════╝

-- ██████╗ ███████╗██╗   ██╗███████╗██████╗ ███╗   ███╗███████╗███╗   ██╗████████╗
-- ██╔══██╗██╔════╝██║   ██║██╔════╝██╔══██╗████╗ ████║██╔════╝████╗  ██║╚══██╔══╝
-- ██║  ██║█████╗  ██║   ██║█████╗  ██████╔╝██╔████╔██║█████╗  ██╔██╗ ██║   ██║   
-- ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██╔═══╝ ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   
-- ██████╔╝███████╗ ╚████╔╝ ███████╗██║     ██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   
-- ╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝╚═╝     ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   
-- https://discord.gg/gxcZgsghzn
