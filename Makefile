DEVELOP=`pwd`

all:
	@cat Makefile

b:
	@touch script.exp
	docker build -t jarvis .

r:
	@echo "DEVELOP: $(DEVELOP)"
	docker run -t -i -v $(DEVELOP):/develop jarvis /bin/bash
