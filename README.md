# Ruby ultimate parser compilation

CLI Tool writen on ruby 3.3.0

## Create parser

To create parser define folder for parser and class which inherits `Dry::CLI::Command`.
Require this class in parser.rb and add class name to PARSER_CLASSES

## Start parsing

````bash
./bin/parser <parser module> <parser type> <arguments>
````

## Help

````bash
./bin/parser --help
````
