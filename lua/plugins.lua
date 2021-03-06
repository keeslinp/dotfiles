local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    use 'arcticicestudio/nord-vim'
    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }},
      config = function()
        local actions = require('telescope.actions')
        require('telescope').setup{
          defaults = {
            mappings = {
              i = {
                ["<c-k>"] = actions.move_selection_previous,
                ["<c-j>"] = actions.move_selection_next,
              }
            }
          },
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = false,
              override_file_sorter = true,
              case_mode = "smart_case",
            }
          }
        }
      end
    }
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('gitsigns').setup({
          signs = {
            add          = {hl = 'GitGutterAdd'   , text = '+'},
            change       = {hl = 'GitGutterChange', text = '~'},
            delete       = {hl = 'GitGutterDelete', text = '_'},
            topdelete    = {hl = 'GitGutterDelete', text = '‾'},
            changedelete = {hl = 'GitGutterChange', text = '~'},
          }
        })
      end
    }

    use {
	    'nvim-treesitter/nvim-treesitter',
	    config = function()
		    require('nvim-treesitter.configs').setup {ensure_installed = 'maintained', highlight = { enable = true }}
	    end
    }
    use 'b3nj5m1n/kommentary'
    use {
      'christianchiarulli/nvcode-color-schemes.vim',
    }
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {{'kyazdani42/nvim-web-devicons'}},
    }
    use {
      'glepnir/galaxyline.nvim',
        branch = 'main',
        -- your statusline
        config = function() require'status_line' end,
        -- some optional icons
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use 'neovim/nvim-lspconfig'

    use {
      'hrsh7th/nvim-compe',
      config = function()
        require('compe').setup {
          enabled = true;
          autocomplete = true;
          documentation = true;
          source = {
            path = true;
            buffer = true;
            treesitter = true;
            nvim_lsp = true;
            nvim_lua = true;
          }
        }
      end
    }

    use 'alexaandru/nvim-lspupdate'

    use {
      'mhartington/formatter.nvim',
      config = function()
        local prettier = {
              -- prettier
            function()
                return {
                  exe = "prettier",
                  args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
                  stdin = true
                }
              end
          } 
        require('formatter').setup({
          logging = false,
          filetype = {
            javascript = prettier,
            typescript = prettier,
            typescriptreact = prettier,
          }
        })
      end
    }

    --[[ use {
      'pwntester/octo.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope.nvim'}},
      config = function()
        require('telescope').load_extension('octo')
      end
    } ]]
end)
