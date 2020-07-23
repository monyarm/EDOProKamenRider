artwork := $(wildcard artwork/*)

default: expansions/KamenRider.cdb pics
expansions/KamenRider.cdb: cards/cards.toml cards/sets.toml cards/macro.toml
	ygofab make

pics: $(artwork)
	ygofab compose -Pall -e KamenRider
	mv pics/EDOPro/* pics/
	rmdir pics/EDOPro

