-- LAMMPS File type
vim.filetype.add {
    extension = {
        lmp = 'lammps',
    },

    pattern = {
        -- These are lua matching patterns, not regex
        ['.*%.lmp'] = 'lammps',
        ['in%..*'] = 'lammps',
        ['.*%.in'] = 'lammps',
    },
}
