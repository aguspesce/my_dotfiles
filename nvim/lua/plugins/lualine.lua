-- Status line

-- Configure lualine
local function getWords()
    if vim.bo.filetype == 'tex' or vim.bo.filetype == 'txt' or vim.bo.filetype == 'markdown' then
        if vim.fn.wordcount().visual_words == 1 then
            return tostring(vim.fn.wordcount().visual_words) .. ' word'
        elseif not (vim.fn.wordcount().visual_words == nil) then
            return tostring(vim.fn.wordcount().visual_words) .. ' words'
        else
            return tostring(vim.fn.wordcount().words) .. ' words'
        end
    else
        return ''
    end
end

-- Define function for getting conda environment
local function getCondaEnv()
    if vim.bo.filetype ~= 'python' then
        return ''
    end
    local conda_env = os.getenv('CONDA_DEFAULT_ENV')
    if conda_env == '' then
        return ''
    end
    return ' ' .. conda_env
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = { theme = 'dracula' },
            sections = {
                lualine_b = { 'branch', 'diff', getCondaEnv, 'diagnostics' },
                lualine_c = {
                    {
                        'filename',
                        file_status = true, -- Displays file status (read only status, modified status)
                        path = 1            -- 0 = just filename, 1 = relative path, 2 = absolute path
                    }
                },
                lualine_y = { getWords }, -- uSe only getWords and remove 'progress'
            },
        })
    end
}
