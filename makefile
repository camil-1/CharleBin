install:
	bin/composer install

start:
	php -S localhost:8080

test:
	# cd tst && ../vendor/bin/phpunit
	./vendor/bin/phpunit tst

lint:
	php -l $(shell find . -name '*.php')
	./vendor/bin/phpcs
	./vendor/bin/phpmd lib ansi ruleset.xml
