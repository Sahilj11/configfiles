local dap = require("dap")
require("dapui").setup()

dap.configurations.java = {
    {
        name = "Debug Launch (2GB)",
        type = "java",
        request = "launch",
        vmArgs = "" .. "-Xmx2g ",
    },
    {
        type = "java",
        request = "attach",
        name = "Attach to the process(5005)",
        hostName = "localhost",
        port = "5005",
    },
    {
        type = "java",
        request = "attach",
        name = "Attach to the process(8000)",
        hostName = "localhost",
        port = "8000",
    },
}
-- require("nvim-dap-virtual-text").setup()
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
vim.keymap.set("n","<space>?",function ()
    dapui.eval(nil,{enter = true})
end)
