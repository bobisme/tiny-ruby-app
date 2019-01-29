export DB_HOST := 127.0.0.1
export DB_USER := root
export DB_PASS := root

TESTS := $(shell find tests -name '*_spec.rb')

run:
	rackup

init-db:
	bundle exec ruby scripts/init-db.rb

test:
	for testfile in $(TESTS); do \
		bundle exec ruby -Ilib:./ "$$testfile"; \
	done

start-db:
	docker run --rm -dt --name mysql --tmpfs /var/lib/mysql:rw,noexec,nosuid,size=512m -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql:5.7

stop-db:
	docker stop mysql
