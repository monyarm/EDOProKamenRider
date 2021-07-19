artwork := $(wildcard artwork/*jpg artwork/*.png)

default: KamenRider.cdb pics


KamenRider.cdb: cards/cards.toml cards/sets.toml cards/macro.toml config.toml Makefile
	ygofab make
	cp expansions/* .

pics: $(artwork) config.toml cards/cards.toml cards/sets.toml cards/macro.toml Makefile
	ygofab compose -p EDOPro -Eall
	rm -rf pics/field
	mv pics/EDOPro/* pics/
	rmdir pics/EDOPro

