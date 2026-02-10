install:
	bin/composer install

start:
	php -S localhost:8080

test:
	# cd tst && ../vendor/bin/phpunit
	./vendor/bin/phpunit tst

dev:
	php -dxdebug.mode=debug -dxdebug.start_with_request=yes -S localhost:8080
