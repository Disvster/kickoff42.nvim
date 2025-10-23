return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('spectre').setup({
      result_padding = ' ',
      default = {
        replace = { cmd = 'sed' }
      }
    })
  end
}
