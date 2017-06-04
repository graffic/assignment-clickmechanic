# SimpleWarehouse

In memory warehouse code assignment for ClickMechanic.com


## Installation

So you just cloned this repository. Assuming a *development* installation.

* Go to the directory where this file is.
* `bundle install` (You will need bundler installed)
* Run tests `rake test`
* Run the cli `bundle exec warehouse`

## Development notes

The application is divided in 3 parts:

* The CLI
* The command system with commands
* The in memory warehouse

The idea was to have only one layer dealing with real input/output and leave the rest to work with strings. After that, many commands share the same repetitive code, so the `CommandRouter` encapsulates all the common logic behind commands.

Each command has access to the command router and the warehouse and they return a status symbol and some output. The status symbol is used to break the loop, and any string returned will be shown. The base command has access to filtering and argument extraction using regular expressions, like url matches in a webframework.

The last part is the in memory warehouse with the `Crate` and the `StoredCrate`.

### Things to improve

Let's start from the `Warehouse`. It has some abstractions for `Crate` and `StoredCrate` that might not be needed. In the end those abstractions might do things a bit more verbose. 

The `Warehouse` doesn't use any index when finding products, nor it keeps a ready bit-map of free space. If the warehouse was to be big, this would slow things down.

Commands gather and prepare data to be shown. They need to know what symbols to return for the cli to work or exit, so they're not fully abstracted. Argument parsing could be better but I guess it will make things more complex.

The `CLI` itself could be better unit tested. In the end I focused more in the end to end test that runs a script.
