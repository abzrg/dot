-- Installation:
--  - rustup component add rust-src
--  - brew install rust-analyzer
return {
  cmd = { "rust-analyzer" },
  filetype = { "rust" },
  root_dir = require("lspconfig.util").root_pattern("Cargo.toml", "rust-project.json"),
  settings = {
    -- ["rust-analyzer"] = {}
  }
}
