check:
	pre-commit run --all-files

builddeb: autoversion
	dpkg-buildpackage -us -uc -b

autoversion:
	date +%Y.%m.%d.%H.%M-git`git rev-list -n1 HEAD | cut -b1-8` > .version
	rm -f debian/changelog
	DEBFULLNAME="Open Computing Facility" DEBEMAIL="help@ocf.berkeley.edu" VISUAL=true \
		dch -v `cat .version` -D stable --no-force-save-on-release \
		--create --package "ocf-create" "Package for Debian."

test: autoversion check

clean:
	rm -rf debian/ocf-create debian/*.debhelper create.egg-info debian/*.log debian/ocf-create.substvars
