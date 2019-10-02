FORMAT: 1A
HOST: http://hostname.com
# Dox Example

This api is implemented according to the JSON API spec.

### Filter

If you want to filter your query, you can do so by setting the supported filter parameters in the following way:

- `?author_id=24`

# Group Authors
Authors group

## Authors [/authors]


### Get authors [GET /api/v1/authors]


+ Request returns a list of authors
**GET**&nbsp;&nbsp;`/api/v1/authors`

    + Headers

            Accept: application/vnd.api+json
            Content-Type: application/vnd.api+json

+ Response 200

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": [
                {
                  "id": "1",
                  "type": "authors",
                  "attributes": {
                    "name": "Author_1"
                  },
                  "relationships": {
                    "books": {
                      "meta": {
                        "included": false
                      }
                    }
                  }
                }
              ]
            }
