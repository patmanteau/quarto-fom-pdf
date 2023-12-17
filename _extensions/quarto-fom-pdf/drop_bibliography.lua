if quarto.doc.is_format("pdf") then
    return {
        -- {
        --     Div = function(div)
        --         if div.identifier == 'refs' then
        --             div.content:insert(pandoc.RawBlock('latex', '\\vspace{1em}'))
        --             return div
        --         end
        --     end
        -- },
        {
            Header = function(header)
                if header.identifier == 'nolatex' then
                    return pandoc.RawBlock('latex', '')
                    -- return nil
                end
            end
        }
    }
end
