#!/usr/bin/env bash

bundle exec rspec spec --tag apidoc -f Dox::Formatter --order defined --out public/api/docs/v1/apispec.md

aglio --include-path / -i public/api/docs/v1/apispec.md -o public/api/docs/v1/index.html
