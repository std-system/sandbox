image = foobar

install:
	mkdir -p ./roles
	ansible-galaxy install \
		-p ./roles \
		-r ./requirements.yml

local: install
	docker build \
		--rm  \
		--tag $(image) \
		.

shell:
	docker run \
		--rm \
		-it $(image) \
		/bin/bash -l

clean:
	-docker rm -f $(docker ps -qa)
	-docker rmi -f $(docker images -qa)
