list:
	@sh -c "$(MAKE) -p no_op__ | \
		awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);\
		for(i in A)print A[i]}' | \
		grep -v '__\$$' | \
		grep -v 'make\[1\]' | \
		grep -v 'Makefile' | \
		sort"
# required for list
no_op__:

cont-build:
	echo "Build container"
	docker build --rm=false -t wcollani/flaskapp .

cont-test:
	echo "Test container"
	docker run --name flaskapp -it -p 80:80 --rm=false wcollani/flaskapp

cont-run:
	echo "Test container"
	docker run --name flaskapp -d -p 80:80 --rm=false wcollani/flaskapp

cont-rm:
	echo "Kill and remove container"
	docker kill flaskapp
	docker rm flaskapp
