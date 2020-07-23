artwork := $(wildcard artwork/*)

default: KamenRider.cdb pics


KamenRider.cdb: cards/cards.toml cards/sets.toml cards/macro.toml config.toml
	mkdir expansions
	ygofab make
	mv expansions/* .
	rmdir expansions

pics: $(artwork) config.toml cards/cards.toml cards/sets.toml cards/macro.toml 
	ygopic proxy artwork KamenRider.cdb pics --size 512x --ext png --year 2020 --author monyarm --field

