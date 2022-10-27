dwm_version := 6.4

define apply_patch
	cd dwm/; curl $(strip $(2)) | git apply -v -3
endef

clean:
	rm -rf patches
	rm -rf dwm/
	rm -rf build/
	mkdir patches

.PHONY: patches
apply_patches: dwm/
	$(call apply_patch, "pertag",				"https://dwm.suckless.org/patches/pertag/dwm-pertag-20200914-61bb8b2.diff")
	$(call apply_patch, "dmenu_follow_monitor",		"https://github.com/blkgoose/dwm/commit/d8cbbbc19faabe10554ff90eec94cf5503458d8b.patch")
	$(call apply_patch, "gaps_around_windows",		"https://github.com/blkgoose/dwm/commit/1a84cc975836372941cfc0381fdbc715edeaf4ef.patch")
	$(call apply_patch, "dmenu bar height",			"https://github.com/blkgoose/dwm/commit/d33dee5560d23d888f81f83b323065befca412ae.patch")
	$(call apply_patch, "dmenu_padding",		  	"https://github.com/blkgoose/dwm/commit/fd0efdfe350a28c3538d2fbf3d93a8e06e814085.patch")
	$(call apply_patch, "infobar_remove_center_color",	"https://github.com/blkgoose/dwm/commit/74dbe9afde88d215e1eb23dca663e5933096cfb4.patch")
	$(call apply_patch, "modernize",			"https://github.com/blkgoose/dwm/commit/b7c0af085e8b9d00803139a47ed1b384402da6bf.patch")

dwm/:
	git clone --depth 1 --branch ${dwm_version} git://git.suckless.org/dwm

.PHONY: install
install: build dwm/
	cd dwm/; sudo make config.h install

.PHONY: build
build: clean apply_patches
