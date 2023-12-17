-- function string.trim(s)
--     return (s:gsub("[\r\n]", " "))
-- end

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
                if header.classes:includes('unnumbered') then
                    local header_text = pandoc.write(pandoc.Pandoc(header.content), 'latex', { cite_method = 'biblatex' })
                    return pandoc.RawBlock('latex', string.format('\\addsec{%s}', header_text))
                end
            end
        }
    }
end
