#!/bin/sh

#pre-installation
echo "$(curl -fksSL https://tinyurl.com/luadist)" | bash
alias lua='LuaDist/bin/lua'
alias luadist='LuaDist/bin/luadist'

#install required libraries
#luadist install busted
luadist install luacov

#alias busted='LuaDist/bin/busted'
alias luacov='LuaDist/bin/luacov'
