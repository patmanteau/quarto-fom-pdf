-- Extended figures for LaTeX. Enables setting short captions, float placement and width factor:
-- ```markdown
-- ![Erträge von Food-Trucks [vgl. @Perez_PythonEcosystem_2011, 13]](../assets/ex1_food_truck_profit.pdf){.ext #ref_a_figure short="This is a short figure caption" placement="htbp" width="70%"}
-- ```
Latex_includegraphics = pandoc.template.compile([[
\begin{figure}$if(placement)$[$placement$]$endif$
$if(identifier)$\hypertarget{$identifier$}$endif$
\centering
\includegraphics$if(width)$[width=$width$\textwidth]$endif${$path$}
\caption$if(short_caption)$[$short_caption$]$endif${$caption$}$if(identifier)$\label{$identifier$}$endif$
$if(identifier)$}$endif$
\end{figure}
]])

Latex_input = pandoc.template.compile([[
\begin{figure}$if(placement)$[$placement$]$endif$
$if(identifier)$\hypertarget{$identifier$}$endif$
\centering
\input{$path$}
\caption$if(short_caption)$[$short_caption$]$endif${$caption$}$if(identifier)$\label{$identifier$}$endif$
$if(identifier)$}$endif$
\end{figure}
]])

function string.trim(s)
    return (s:gsub("[\r\n]", " "))
end

local function convert_text(text)
    return pandoc.write(pandoc.read(text), "latex", { cite_method = "biblatex" }):trim()
end

local function render_extended_figure(figure)
    -- logging.temp('image', image)

    if figure.attributes['short'] then
        local short_caption = convert_text(figure.attributes['short'])
    end
    
    -- local placement = image.attributes['latex-placement'] or ''
    -- local identifier = image.identifier
    -- local width = image.attributes['width'] or ''
    -- if width and string.find(width, '%%') then
    --     width = width:gsub('%%', '')
    --     width = string.format("%.2f", tonumber(width) / 100)
    -- end

    -- local path = image.src

    -- local caption = pandoc.write(pandoc.Pandoc(pandoc.Span(image.caption)), 'latex', { cite_method = 'biblatex' }):trim()

    local context = {
        placement = placement,
        width = width,
        path = path,
        short_caption = short_caption,
        caption = caption,
        identifier = identifier
    }

    -- don't use includegraphics on PGF files
    local tex
    if path:sub(-4) == '.pgf' then
        tex = pandoc.template.apply(Latex_input, context)
    else
        tex = pandoc.template.apply(Latex_includegraphics, context)
    end

    return pandoc.RawInline('latex', pandoc.layout.render(tex))
end

local function render_pandoc(pandoc)
    quarto.log.output(pandoc)
end

if quarto.doc.is_format("pdf") then
    return {
        {
            -- Figure = render_extended_figure,
            Figure = render_pandoc
        }
    }
end
