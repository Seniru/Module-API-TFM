esc = '\27['
close = esc .. '0m'
bold = esc .. '1m'

yellow = esc .. '93;40m'

function label(txt)
    return bold .. yellow .. txt .. close
end


return escapes