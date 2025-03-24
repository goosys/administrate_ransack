# Development

## Development

```sh
bin/appraisal rails71-administrate rails s
bin/appraisal rails71-administrate rails c
bin/appraisal rails71-administrate rails spec
```

## Upgrade

```sh
bin/appraisal generate
bin/appraisal update
bin/appraisal install
```

## Releases

```sh
# Update lib/administrate_ransack/version.rb with the new version
# Update the gemfiles:
bin/appraisal
```

## Testing

```sh
# Running specs all Rails/Administrate versions:
bin/appraisal rspec
# Running specs per Rails/Administrate versions:
bin/appraisal rails60-administrate rspec
bin/appraisal rails61-administrate rspec
bin/appraisal rails70-administrate rspec
# Using latest Administrate version:
bin/appraisal rails71-administrate rspec
# See gemfiles for more configurations
```
