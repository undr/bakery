# Coding Challenge Solution. Bakery.

### Requirements

- Ruby (2.4.4)

### Setup

- Go to project's folder in your terminal
- run `bundle install`
- run `bin/bakery --help` to learn how it works.

### Help

```
$ bin/bakery --help
Usage: bakery --repo=FILENAME [INPUT]
    -r, --repo=FILENAME              Bakery's data file
    -d, --dev                        Run into development mode
    -h, --help                       Prints this help
```

Use `--repo` option to define data file. You can find examples of this file in `./examples` folder. In interactive mode, it provides REPL terminal.  

```
$ bin/bakery -r ./examples/datafile.origin
Read commands from console.
Available commands: REPORT, PREPACK, RESET, REM code, ADD quantity code.
Press Control+C for exit.

(0.0.1)> |
```

Available commands:

- `report`  - Print order content.
- `prepack` - Pack an order and print result.
- `reset` - Clear order content.
- `rem CODE` - Remove a product with provided code from an order.
- `add QTY CODE` - Add defined quantity of product into an order.

Example:

```
(0.0.1)> add 13 CF
CF item was added into order.
(0.0.1)> rem CF
CF item was removed from order.
(0.0.1)> |
```

It's possible to define input file with list of commands:

```
$ bin/bakery -r ./examples/datafile.origin ./examples/commands.origin
10    VS5    $17.98
    2 x 5    $8.99
14    MB11   $54.8
    1 x 8    $24.95
    3 x 2    $9.95
13    CF     $25.85
    2 x 5    $9.95
    1 x 3    $5.95

```

*__Hint:__ Use development mode to see all exception.*

*__Hint:__ Use `datafile:origin` and `datafile:extended` rake tasks to generate data files.*

```
$ bundle exec rake datafile:origin > ./datafile
$ bundle exec rake datafile:extended > ./datafile
$ bundle exec rake datafile:origin[./datafile]
$ bundle exec rake datafile:extended[./datafile]
```

### Specs

if you want to run the specs please run `bundle exec rspec spec` in project's home directory.

### Known issues and limitations

- Command parser cannot recognize numeric only codes for products in some cases.

  ```
  (0.0.1)> rem 10
  unknown command: rem 10
  (0.0.1)> |
  ```
- It catches all exceptions, but do not log them into a file. Need to add logging system. It would be worth to log all valuable events, but not only exceptions.
