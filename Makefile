APIDOC = python3 tools/doc.py
APIDIR = docs/user/

conda:
	for i in 7 8 9 10; do conda mambabuild -c local -c conda-forge etc/conda --py 3.$i; done

pypa:
	sudo ./etc/pypa/docker-build
	

docs:
	#make apidocs
	#elstir build
	#rm site/**/*.tex
	#rm site/**/*.fig
	git add site && git commit -m'cmp - rebuild site' && git subtree push --prefix site/ brace gh-pages

apidocs:
	$(APIDOC) opensees.section > $(APIDIR)/modeling/section/index.md
	$(APIDOC) opensees.patch > $(APIDIR)/modeling/section/patch.md
	$(APIDOC) opensees.patch --attr layer > $(APIDIR)/modeling/section/layer.md
	$(APIDOC) opensees.lib > $(APIDIR)/core.md
	$(APIDOC) opensees.lib --attr uniaxial > $(APIDIR)/modeling/uniaxial.md
	$(APIDOC) opensees.lib --attr element > $(APIDIR)/modeling/element.md
	$(APIDOC) opensees.lib --attr constraint > $(APIDIR)/modeling/constraint.md

test:
	pytest --nbmake notebooks/

.PHONY: docs
