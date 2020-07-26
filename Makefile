artwork := $(wildcard artwork/*)

default: KamenRider.cdb pics


KamenRider.cdb: cards/cards.toml cards/sets.toml cards/macro.toml config.toml Makefile
	#mkdir expansions
	ygofab make
	cp expansions/* .
	#rmdir expansions

pics: $(artwork) config.toml cards/cards.toml cards/sets.toml cards/macro.toml Makefile
	#ygopic proxy artwork KamenRider.cdb pics --size 512x --ext png --year 2020 --author monyarm --field
	ygofab compose -Pall -Eall
	rm -rf pics/field
	mv pics/EDOPro/* pics/
	rmdir pics/EDOPro

