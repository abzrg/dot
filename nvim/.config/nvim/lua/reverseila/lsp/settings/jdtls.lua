local util = require("lspconfig.util")

return {
  cmd = { "jdtls" },
  filetypes = { 'java' },
  root_dir = function(fname)
        local root_files = {
          'build.xml',       -- Ant
          'pom.xml',         -- Maven
          'settings.gradle', -- Gradle
          'settings.gradle.kts', -- Gradle
          'build.gradle',
          'build.gradle.kts',
        }
        return util.root_pattern(unpack(root_files))(fname) or
            util.find_git_ancestor(fname) or util.path.dirname(fname)
      end or function()
        return vim.loop.cwd()
      end
  ,
  single_file_support = true
}
