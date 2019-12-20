esc = '\27['
close = esc .. '0m'
bold = esc .. '1m'
italic = esc .. '3m'

grey = esc .. '2m'
yellow = esc .. '93;40m'

function label(txt)
    return bold .. yellow .. txt .. close
end

function func(f)
    return italic .. grey .. f .. close
end

function col(txt, r, g, b, fg)
    return esc .. ((fg == nil or fg == true) and 38 or 48) .. ';2;' .. r .. ';' .. g .. ';' .. b .. 'm' .. txt .. close
end

return escapes