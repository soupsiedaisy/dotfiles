return {
	"nvim-treesitter/nvim-treesitter",
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
	build = ":TSUpdate"
}
-- add "nvim-treesitter/playground" to have access to parser info
