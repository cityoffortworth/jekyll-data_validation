# jekyll-data_validation

Jekyll plugin that adds a `jekyll validate` command for validating data (front-matter) in Jekyll posts and pages using a JSON schema. JSON schema is way of defining expectations about JSON data including required fields, allowed values, etc. See the [JSON Schema website](http://json-schema.org/) for more information.

This gem also includes a set of custom date formats that allow users to specify dates in a more friendly matter (as opposed to RFC 3339 compliant dates).

## Usage

0. Define the JSON schema as YAML in the _config.yml file under a section named `data_validation`. See [`_config.yml`](https://github.com/cityoffortworth/jekyll-data_validation/blob/master/test/fixtures/_config.yml) for an example.
0. Run `jekyll validate` and check the output for validation errors.

### `jekyll validate`

The `jekyll validate` command takes the same `--config` option as `jekyll build`. There is also a `--autofix` option that will attempt to fix validation formatting issues with dates.

### User Date Formats

There are three custom date formats - `user-date`, `user-time`, and `user-date-time`. To validate dates using the RFC 3339 standard use the built-in `date-time` format.

- `user-date` expects a format of `YYYY-MM-DD`
- `user-time` expects a format of `HH:MM`
- `user-date-time` expects a formate of `YYYY-MM-DD HH:MM`

See the [tests](https://github.com/cityoffortworth/jekyll-data_validation/blob/master/test) for more details.
