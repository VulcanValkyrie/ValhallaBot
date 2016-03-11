#!/bin/bash

read nick chan saying

function has { $(echo "$1" | grep -P "$2" > /dev/null) ; }

function say { echo "PRIVMSG $1 :$2" ; }

if has "$saying" "^!witnessme$" ; then
    say $chan "$nick: WITNESSED"
fi

if has "$saying" "^oh what a day" ; then
    say $chan "what a lovely day!"
fi

if has "$saying" "\bhope\b" ; then
    say $chan "$nick: You know, hope is a mistake. If you can't fix what's broken, you'll, uh... you'll go insane."
    say $chan "- \"Mad\" Max Rockatansky"
fi

if had "$saying" "^!valhalla$" ; then
    say $chan "$nick: the sole purpose at this bot is to yell mad max things at you."
fi

if has "$saying" "^i live"  ; then
    say $chan "I LIVE, I DIE, I LIVE AGAIN"
fi
if has "$saying" "!warboy$" ; then
    say $chan "I AM THE MAN WHO GRABS THE SUN, RIDING TO VALHALLA!"
    say $chan "IF I'M GOING TO DIE, I'M GOING TO DIE HISTORIC, ON THE FURY ROAD!"
fi
