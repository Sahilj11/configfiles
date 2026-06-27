local jdtls = require("jdtls")

-- Dynamically resolve paths
local home = vim.fn.expand("~")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = home .. "/.cache/jdtls-workspace/" .. project_name
local path_to_lombok = home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar"

local launcher_path = vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")

if launcher_path == "" then
  vim.notify("JDTLS: Equinox launcher not found. Is jdtls installed via Mason?", vim.log.levels.ERROR)
  return
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "-javaagent:" .. path_to_lombok,
    "-Xbootclasspath/a:" .. path_to_lombok, -- Restored missing Lombok argument
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    launcher_path, -- Using the dynamic glob path
    "-configuration",
    home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
    "-data",
    workspace_dir,
  },
  filetypes = { "java" },

  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

  settings = {
    java = {
      foldingRange = { enabled = true },
      signatureHelp = { enabled = true },
      eclipse = {
        downloadSources = true,
      },
      import = {
        gradle = { enabled = true },
        maven = { enabled = true },
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-17",
            path = home .. "/.sdkman/candidates/java/17.0.18-zulu",
          },
          {
            name = "JavaSE-21",
            path = home .. "/.sdkman/candidates/java/21.0.9-zulu",
            default = true,
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
      contentProvider = {
        preferred = "fernflower",
      },
      extendedClientCapabilities = jdtls.extendedClientCapabilities,
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
    },
  },
}

jdtls.start_or_attach(config)
