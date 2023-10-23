local status_ok, symbols_outline = pcall(require, "symbols-outline")
if (not status_ok) then
  return
end

symbols_outline.setup()


      --                              ----------
      --                               BINDINGS
      --                              ----------
      --
      -- +------------+-----------------------------------------------------+
      -- | Escape.....|..Close outline                                      |
      -- | Enter......|..Go to symbol location in code                      |
      -- | o..........|..Go to symbol location in code without losing focus |
      -- | Ctrl+Space.|..Hover current symbol                               |
      -- | K..........|..Toggles the current symbol preview                 |
      -- | r..........|..Rename symbol                                      |
      -- | a..........|..Code actions                                       |
      -- | h..........|..fold symbol                                        |
      -- | l..........|..Unfold symbol                                      |
      -- | W..........|..Fold all symbols                                   |
      -- | E..........|..Unfold all symbols                                 |
      -- | R..........|..Reset all folding                                  |
      -- | ?..........|..Show help message                                  |
      -- +------------+-----------------------------------------------------+

