-- Convert abbreviations to custom LaTeX commands
return {
    {
        Str = function(elem)
            lookup = {
                ["a.a.O"] = "\\AbbreVaaO",
                ["a. a. O."] = "\\AbbreVaaO",
                ["d.h."] = "\\AbbreVdh",
                ["d. h."] = "\\AbbreVdh",
                ["hrsg.v."] = "\\AbbreVhrsgv",
                ["hrsg. v."] = "\\AbbreVhrsgv",
                ["o.O."] = "\\AbbreVoO",
                ["o. O."] = "\\AbbreVoO",
                ["o.J."] = "\\AbbreVoJ",
                ["o. J."] = "\\AbbreVoJ",
                ["i.d.R."] = "\\AbbreVidR",
                ["i. d. R."] = "\\AbbreVidR",
                ["i.F."] = "\\AbbreViF",
                ["i. F."] = "\\AbbreViF",
                ["u.a."] = "\\AbbreVua",
                ["u. a."] = "\\AbbreVua",
                ["z.B."] = "\\AbbreVzB",
                ["z. B."] = "\\AbbreVzB",
            }

            sub = lookup[elem.text]
            if sub then
                -- must use RawInline instead of Str to prevent Pandoc escaping the backslash
                return pandoc.RawInline("latex", sub)
            end
        end,
    }
}
