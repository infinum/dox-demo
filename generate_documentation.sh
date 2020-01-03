#!/usr/bin/env bash

bundle exec rspec --tag apidoc -f Dox::Formatter --order defined --out spec/api_doc/v1/schemas/output.json

redoc-cli bundle -o public/api/docs/v2/index.html spec/api_doc/v1/schemas/output.json
