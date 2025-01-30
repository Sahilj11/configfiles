local ls = require("luasnip")
local s = ls.snippet
local sn = ls.sn
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
-- local fmt = require("luasnip.extras.fmt").fmt
-- vim.keymap.set({ "i", "s" }, "<A-n>", function()
--     if ls.choice_active() then
--         ls.change_choice(1)
--     end
-- end)
-- stylua: ignore start
--thymeleaf html

local getPackageName = function()
    local filepath = vim.fn.expand('%:p')
    local project_dir = vim.fn.getcwd()
    local relative_path = filepath:gsub(project_dir .. "/src/main/java/", ""):gsub("/", ".")
    local fileName = vim.fn.expand('%:t')
    local package_name = relative_path:gsub("%." .. fileName .. "$", "")
    return package_name or "com.example.package"
end

local function get_comment_prefix()
    local filetype = vim.bo.filetype
    if filetype == "java" or filetype == "javascript" or filetype == "c" then
        return "//"
    elseif filetype == "python" or filetype == "sh"  then
        return "#"
    elseif  filetype == "lua"then
        return "--"
    elseif filetype == "html" or filetype == "xml" then
        return "<!--"
    else
        return "//" -- Default to C-style comments
    end
end

-- Function to add closing comment syntax for HTML/XML
local function get_html_xml_end_comment()
    local filetype = vim.bo.filetype
    if filetype == "html" or filetype == "xml" then
        return " -->"
    else
        return ""  -- No closing comment for other file types
    end
end

-- Create snippets with dynamic comment prefixes
ls.add_snippets("all", {
    s("todo", {
        d(1, function()
            return sn(nil, { t(get_comment_prefix() .. " TODO: ") ,i(1,"What else?")})
        end),
        d(2, function()
            return sn(nil, { t(get_html_xml_end_comment()) })
        end),
    }),
    s("fix", {
        d(1, function()
            return sn(nil, { t(get_comment_prefix() .. " FIX: ") ,i(1,"this needs fixing")})
        end),
        d(2, function()
            return sn(nil, { t(get_html_xml_end_comment()) })
        end),
    }),
    s("note", {
        d(1, function()
            return sn(nil, { t(get_comment_prefix() .. " NOTE: ") ,i(1,"adding a note")})
        end),
        d(2, function()
            return sn(nil, { t(get_html_xml_end_comment()) })
        end),
    }),
    s("warning", {
        d(1, function()
            return sn(nil, { t(get_comment_prefix() .. " WARNING: ") ,i(1,"???")})
        end),
        d(2, function()
            return sn(nil, { t(get_html_xml_end_comment()) })
        end),
    }),
    s("perf", {
        d(1, function()
            return sn(nil, { t(get_comment_prefix() .. " PERF: ") ,i(1,"fully optimised")})
        end),
        d(2, function()
            return sn(nil, { t(get_html_xml_end_comment()) })
        end),
    }),
    s("hack", {
        d(1, function()
            return sn(nil, { t(get_comment_prefix() .. " HACK: ") ,i(1,"hmm,this looks a bit funky")})
        end),
        d(2, function()
            return sn(nil, { t(get_html_xml_end_comment()) })
        end),
    }),
})
ls.add_snippets("java", {
    s("getc", fmt([[
       @GetMapping(path="{}")
       public {} {}({}){{
           {}
       }}
    ]], {
        i(1, "url"),
        i(2, "void"),
        i(3, "name"),
        i(4, "variable"),
        i(5),
    })),
    s("postc", fmt([[
       @PostMapping(path="{}")
       public {} {}({}){{
           {}
       }}
    ]], {
        i(1, "url"),
        i(2, "void"),
        i(3, "name"),
        i(4, "variable"),
        i(5),
    })),
    s("putc", fmt([[
       @PutMapping(path="{}")
       public {} {}({}){{
           {}
       }}
    ]], {
        i(1, "url"),
        i(2, "void"),
        i(3, "name"),
        i(4, "variable"),
        i(5),
    })),
    s("delc", fmt([[
       @DeleteMapping(path="{}")
       public {} {}({}){{
           {}
       }}
    ]], {
        i(1, "url"),
        i(2, "void"),
        i(3, "name"),
        i(4, "variable"),
        i(5),
    })),
    s("patchc", fmt([[
       @PatchMapping(path="{}")
       public {} {}({}){{
           {}
       }}
    ]], {
        i(1, "url"),
        i(2, "void"),
        i(3, "name"),
        i(4, "variable"),
        i(5),
    })),
    s("psff", fmt([[
        public static final {} {} = {};
    ]], {
        i(1, "String"),
        i(2, "VARIABLE"),
        i(3, "value")
    })),
    s("psc", fmt([[
        public static class {}{{

        }}
    ]], {
        i(1, "className")
    })),
    s("p_field", fmt([[
        private {} {};
    ]], {
        i(1, "String"),
        i(2, "variable")
    })),
    s("pff", fmt([[
        private final {} {};
    ]], {
        i(1, "String"),
        i(2, "variable")
    })),
    s("entity", fmt([[
        package {};

        import org.springframework.data.annotation.Id;
        import jakarta.persistence.Entity;
        import jakarta.persistence.GeneratedValue;
        import jakarta.persistence.GenerationType;
        import jakarta.persistence.Table;

        @Entity
        @Table(name = "{}")
        public class {} {{

            @Id
            @GeneratedValue(strategy = GenerationType.IDENTITY)
            private Long id;

        }}]], {
        f(getPackageName, {}),
        i(1, "table_name"),
        f(function()
            return vim.fn.expand('%:t:r')
        end, {})
    })),
    s("repo", fmt([[
       package {};

       import org.springframework.data.jpa.repository.JpaRepository;

       /**
         * {}
        */
       public interface {} extends JpaRepository<{},Long>{{
       }}
    ]], {
        f(getPackageName, {}),
        rep(1),
        f(function()
            return vim.fn.expand('%:t:r')
        end, {}),
        i(1, "entity")
    })),
    s("cexcep",fmt([[
        package {};

        /**
         * {}
         */
        public class {} extends RuntimeException{{

            public {}(String message){{
               super(message);
            }}

            public {}(String message,Throwable cause){{
               super(message,cause);
            }}
        }}
    ]],{
        f(getPackageName,{}),
        f(function()
            return vim.fn.expand('%:t:r')
        end, {}),
        f(function()
            return vim.fn.expand('%:t:r')
        end, {}),
        f(function()
            return vim.fn.expand('%:t:r')
        end, {}),
        f(function()
            return vim.fn.expand('%:t:r')
        end, {}),
    })),
    s("nswitch",fmt([[
        switch({}){{
            case {}->{{

            }}
            default->{{

            }}
        }}
    ]],{
        i(1,"var"),
        i(2,"CASE")
    }))
})
-- stylua: ignore end
ls.add_snippets("css", {
    s(
        "star",
        fmt(
            [[
        *{{
            padding:0;
            margin:0;
            box-sizing:border-box;
        }}
    ]],
            {}
        )
    ),
})
