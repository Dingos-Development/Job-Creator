local jobMenu = nil

-- Create the Job Creator Menu
function createJobMenu()
    jobMenu = NativeUI.CreateMenu("Job Creator", "Add new jobs to your server")
    _menuPool:Add(jobMenu)

    -- Add option to create a new job
    local createNewJob = NativeUI.CreateItem("Create New Job", "Add a new job to your server")
    createNewJob.Activated = function(sender, item)
        if item == createNewJob then
            openCreateJobDialog()
        end
    end
    jobMenu:AddItem(createNewJob)

    -- Add existing jobs to the menu
    TriggerServerEvent('jobcreator:getJobs')
end

-- Function to open the job creation dialog
function openCreateJobDialog()
    local dialog = exports['qb-input']:ShowInput({
        header = "Create a New Job",
        submitText = "Create",
        inputs = {
            { type = "text", name = "label", text = "Job Name (Required)" },
            { type = "text", name = "id", text = "Job ID (Required)" }
        }
    })

    if dialog then
        if not dialog.label or dialog.label:match("^%s*$") or not dialog.id or dialog.id:match("^%s*$") then
            TriggerEvent('QBCore:Notify', "All fields are required.", "error")
            return
        end
        TriggerServerEvent('jobcreator:createJob', dialog)
    end
end

-- Function to display jobs in the menu
RegisterNetEvent('jobcreator:receiveJobs', function(jobs)
    for jobId, job in pairs(jobs) do
        local jobItem = NativeUI.CreateItem(job.label .. " (" .. jobId .. ")", "Edit job details")
        jobItem.Activated = function(sender, item)
            if item == jobItem then
                openEditJobMenu(jobId, job)
            end
        end
        jobMenu:AddItem(jobItem)
    end
    jobMenu:Visible(true)
end)

-- Function to open the edit job menu
function openEditJobMenu(jobId, job)
    local editMenu = NativeUI.CreateMenu("Edit Job: " .. job.label, "Edit job grades and salaries")
    _menuPool:Add(editMenu)

    for grade, info in pairs(job.grades) do
        local gradeItem = NativeUI.CreateItem("Grade " .. grade .. ": $" .. info.salary, "Click to edit salary")
        gradeItem.Activated = function(sender, item)
            if item == gradeItem then
                openEditGradeDialog(jobId, grade, info.salary)
            end
        end
        editMenu:AddItem(gradeItem)
    end

    local backItem = NativeUI.CreateItem("Back", "Go back to the main menu")
    backItem.Activated = function(sender, item)
        if item == backItem then
            editMenu:Visible(false)
            jobMenu:Visible(true)
        end
    end
    editMenu:AddItem(backItem)
    editMenu:Visible(true)
end

-- Function to open the grade editing dialog
function openEditGradeDialog(jobId, grade, currentSalary)
    local dialog = exports['qb-input']:ShowInput({
        header = "Edit Grade " .. grade .. " Salary",
        submitText = "Save",
        inputs = {
            { type = "number", name = "salary", text = "New Salary", default = tostring(currentSalary) }
        }
    })

    if dialog then
        if not dialog.salary or tonumber(dialog.salary) <= 0 then
            TriggerEvent('QBCore:Notify', "Salary must be greater than 0.", "error")
            return
        end
        TriggerServerEvent('jobcreator:setGradeSalary', {
            id = jobId,
            grade = grade,
            salary = tonumber(dialog.salary)
        })
    end
end

-- Command to open the Job Creator
RegisterCommand('jobcreator', function(_, args)
    if not jobMenu then
        createJobMenu()
    end
    _menuPool:RefreshIndex()
    jobMenu:Visible(true)
end, false)

_menuPool = NativeUI.CreatePool()
_menuPool:RefreshIndex()

-- Tick to process NativeUI
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
    end
end)

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
