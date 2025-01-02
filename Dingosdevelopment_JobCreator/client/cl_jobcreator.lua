local jobData = {}

-- Function to open the main menu
function openMainMenu()
    local options = {
        {
            label = '💼 Add New Job',
            description = 'Create a new job for your server',
            event = 'jobcreator:addNewJob'
        },
        {
            label = '📜 View All Jobs',
            description = 'See all existing jobs',
            event = 'jobcreator:viewJobs'
        }
    }

    lib.registerContext({
        id = 'main_menu',
        title = '🔵 Job Creator',
        description = 'Manage server jobs',
        options = options
    })

    lib.showContext('main_menu')
end

-- Function to handle adding a new job
RegisterNetEvent('jobcreator:addNewJob', function()
    local input = lib.inputDialog('Add New Job', {
        { type = 'input', label = 'Job Name', placeholder = 'Enter job name', required = true },
        { type = 'input', label = 'Job ID', placeholder = 'Enter job ID', required = true }
    })

    if not input then return end -- Cancelled

    jobData = { name = input[1], id = input[2], grades = {} }
    openEditPayMenu()
end)

-- Function to open the edit pay menu
function openEditPayMenu()
    local options = {
        {
            label = '💰 Edit Pay for Grades',
            description = 'Set salaries for each grade',
            event = 'jobcreator:editPay'
        },
        {
            label = '✅ Submit Job',
            description = 'Save this job with its grades',
            event = 'jobcreator:submitJob'
        }
    }

    lib.registerContext({
        id = 'edit_pay_menu',
        title = '💵 Edit Job Pay',
        description = 'Customize job grades and pay',
        options = options
    })

    lib.showContext('edit_pay_menu')
end

-- Function to edit pay for grades
RegisterNetEvent('jobcreator:editPay', function()
    local input = lib.inputDialog('Set Grade Salaries', {
        { type = 'number', label = 'Grade 1 Salary', default = 0, required = true },
        { type = 'number', label = 'Grade 2 Salary', default = 0, required = true },
        { type = 'number', label = 'Grade 3 Salary', default = 0, required = true },
        { type = 'number', label = 'Grade 4 Salary', default = 0, required = true }
    })

    if not input then return end -- Cancelled

    -- Save salaries to job data
    for i = 1, 4 do
        jobData.grades[i] = { salary = tonumber(input[i]) }
    end

    openEditPayMenu() -- Return to the edit pay menu
end)

-- Function to handle job submission
RegisterNetEvent('jobcreator:submitJob', function()
    -- Validate job data
    for i = 1, 4 do
        if not jobData.grades[i] then
            lib.notify({
                description = 'Salary for Grade ' .. i .. ' is missing!',
                type = 'error'
            })
            return
        end
    end

    -- Send job data to the server
    TriggerServerEvent('jobcreator:createJob', jobData)

    -- Reset job data and return to main menu
    jobData = {}
    lib.notify({ description = 'Job created successfully!', type = 'success' })
    openMainMenu()
end)

-- Function to view all jobs
RegisterNetEvent('jobcreator:viewJobs', function()
    TriggerServerEvent('jobcreator:getAllJobs')
end)

-- Event to display all jobs
RegisterNetEvent('jobcreator:showAllJobs', function(jobs)
    local options = {}

    for jobId, jobInfo in pairs(jobs) do
        table.insert(options, {
            label = jobInfo.label,
            description = 'Job ID: ' .. jobId
        })
    end

    table.insert(options, {
        label = '🔙 Back',
        description = 'Return to the main menu',
        event = 'jobcreator:backToMain'
    })

    lib.registerContext({
        id = 'view_jobs_menu',
        title = '📋 All Jobs',
        description = 'List of all current jobs',
        options = options
    })

    lib.showContext('view_jobs_menu')
end)

-- Function to return to the main menu
RegisterNetEvent('jobcreator:backToMain', function()
    openMainMenu()
end)

-- Command to open the main menu
RegisterCommand('jobcreator', function()
    openMainMenu()
end)
