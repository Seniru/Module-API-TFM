#!/bin/sh

#pre-installation
curl -fksSL https://tinyurl.com/luadist | bash

export lua='LuaDist/bin/lua'
export luadist='LuaDist/bin/luadist'

#install required libraries
#luadist install busted
LuaDist/bin/luadist install luacov

#alias busted='LuaDist/bin/busted'
export luacov='LuaDist/bin/luacov'
