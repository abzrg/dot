require 'nvim-startup'.setup {
    startupfile = '/tmp/nvim-startuptime', -- sets startup log path (string)
    message = function(time) -- function-based custom message
        return (time < 100) and 'Just {}? really good!' or 'Those {} can get faster'
    end
}
