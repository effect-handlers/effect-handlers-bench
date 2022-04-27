DOCKERHUB=effecthandlers/effect-handlers
IMAGE=$(DOCKERHUB):eff-explicit-effect-subtyping
DOCKER_RUN = docker run -it --init -v $(shell pwd):/source $(IMAGE)

system:
	docker pull $(IMAGE)

# Runs artifact provided benchmarks
benchmark: system
	$(DOCKER_RUN) make benchmark                                                                                                                                                                             

# Compile custom file to plain ocaml file 
compilefile: system
	$(DOCKER_RUN) bash -c "./eff.exe --no-stdlib --compile-plain-ocaml /source/$(TARGET_EFF_FILE).eff > /source/ocaml_code.ml"

runml: system
	$(DOCKER_RUN) bash -c "./eff.exe --no-stdlib --compile-plain-ocaml /source/$(TARGET_EFF_FILE).eff > /source/ocaml_code.ml"
	$(DOCKER_RUN) bash -c "ocaml ocamlHeader/ocamlHeader.ml /source/ocaml_code.ml"
