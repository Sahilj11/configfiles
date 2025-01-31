local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local path_to_lombok = "/home/sahil/.local/share/nvim/mason/packages/jdtls/lombok.jar"
local path_to_java_dap = "/home/sahil/.local/share/nvim/mason/share/java-debug-adapter/"
local jdtlsS = require("jdtls")
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        -- 💀
        "java", -- or '/usr/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "-javaagent:" .. path_to_lombok,
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        -- "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        -- "-Dosgi.bundles.defaultStartLevel=4",
        -- "-Declipse.product=org.eclipse.jdt.ls.core.product",
        -- "-Dlog.protocol=true",
        -- "-Dlog.level=ALL",
        -- "-javaagent:" .. path_to_lombok,
        -- "-Xmx1g",
        -- "--add-modules=ALL-SYSTEM",
        -- "--add-opens",
        -- "java.base/java.util=ALL-UNNAMED",
        -- "--add-opens",
        -- "java.base/java.lang=ALL-UNNAMED",
        --
        -- 💀
        "-jar",
        "/home/sahil/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version

        -- 💀
        "-configuration",
        "/home/sahil/.local/share/nvim/mason/packages/jdtls/config_linux",
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.

        -- 💀
        -- See `data directory configuration` section in the README
        "-data",
        vim.fn.expand("/home/sahil/.cache/jdtls-workspace") .. workspace_dir,
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            signatureHelp = { enabled = true },
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-11",
                        path = "/usr/lib/jvm/java-11-openjdk",
                        -- projects = { "my-java-11-project" }, -- Use Java 11 for this project
                    },
                    {
                        name = "JavaSE-21",
                        path = "/usr/lib/jvm/java-21-openjdk",
                        default = true, -- Use this as the default Java version
                    },
                },
            },
            maven = {
                downloadSources = true,
            },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
                importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org",
                },
            },
            -- implementationsCodeLens = {
            --     enabled = true,
            -- },
            contentProvider = {
                preferred = "fernflower",
            },
            extendedClientCapabilities = jdtlsS.extendedClientCapabilities,
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
            -- referencesCodeLens = {
            --     enabled = true,
            -- },
            format = {
                enabled = true,
                settings = {
                    url = "~/.local/share/nvim/mason/bin/google-java-format",
                    profile = "GoogleStyle",
                },
            },
        },
        -- this is end initial
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {
            vim.fn.glob(path_to_java_dap .. "com.microsoft.java.debug.plugin.jar", true),
        },
    },
    -- init_options = {
    --     bundles = {
    --         -- vim.fn.glob("/home/sahil/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.50.0.jar", 1)
    --     },
    -- },
    capabilities = capabilities,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
config["on_attach"] = function(client, bufnr)
    jdtlsS.setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
end
-- jdtlsS.setup({
--     handlers = {
-- 		-- By assigning an empty function, you can remove the notifications
-- 		-- printed to the cmd
-- 		["$/progress"] = function(_, result, ctx) end,
-- 	},
-- })
jdtlsS.start_or_attach(config)
