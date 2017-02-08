# Dox Example

# Group Authors


## Authors [/authors]


### Get authors [GET /api/v1/authors]


+ Request returns a list of authors
**GET**&nbsp;&nbsp;`/api/v1/authors`

    + Headers



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

### Get an author [GET /api/v1/authors/{id}]

+ Parameters
    + id: `1` (number, required)

+ Request returns an author
**GET**&nbsp;&nbsp;`/api/v1/authors/1`

    + Headers



+ Response 200

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": {
                "id": "1",
                "type": "authors",
                "attributes": {
                  "name": "Author_2"
                },
                "relationships": {
                  "books": {
                    "data": [
            
                    ]
                  }
                }
              }
            }

### Create an author [POST /api/v1/authors]


+ Request creates a new Author
**POST**&nbsp;&nbsp;`/api/v1/authors`

    + Headers

            Content-Type: application/x-www-form-urlencoded

    + Body

            {
              "author": {
                "name": "Author_4"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": {
                "id": "2",
                "type": "authors",
                "attributes": {
                  "name": "Author_4"
                },
                "relationships": {
                  "books": {
                    "meta": {
                      "included": false
                    }
                  }
                }
              }
            }

### Update an author [PUT /api/v1/authors/{id}]

+ Parameters
    + id: `1` (number, required)

+ Request updates the requested author
**PUT**&nbsp;&nbsp;`/api/v1/authors/1`

    + Headers

            Content-Type: application/x-www-form-urlencoded

    + Body

            {
              "author": {
                "name": "New Author"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": {
                "id": "1",
                "type": "authors",
                "attributes": {
                  "name": "New Author"
                },
                "relationships": {
                  "books": {
                    "meta": {
                      "included": false
                    }
                  }
                }
              }
            }

### Delete an author [DELETE /api/v1/authors/{id}]

+ Parameters
    + id: `1` (number, required)

+ Request deletes the requested author
**DELETE**&nbsp;&nbsp;`/api/v1/authors/1`

    + Headers

            Content-Type: application/x-www-form-urlencoded

+ Response 204

# Group Books


## Book Collections [/book_collections]


### Get book collections [GET /api/v1/book_collections]


+ Request returns book collections
**GET**&nbsp;&nbsp;`/api/v1/book_collections`

    + Headers



+ Response 200

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": [
                {
                  "id": "1",
                  "type": "book_collections",
                  "attributes": {
                    "name": "Book_collection_1"
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

### Get a book collection [GET /api/v1/book_collections/{id}]

+ Parameters
    + id: `1` (number, required)

+ Request returns a book collection
**GET**&nbsp;&nbsp;`/api/v1/book_collections/1`

    + Headers



+ Response 200

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": {
                "id": "1",
                "type": "book_collections",
                "attributes": {
                  "name": "Book_collection_2"
                },
                "relationships": {
                  "books": {
                    "data": [
            
                    ]
                  }
                }
              }
            }

### Create a book collection [POST /api/v1/book_collections]


+ Request creates a new book collection
**POST**&nbsp;&nbsp;`/api/v1/book_collections`

    + Headers

            Content-Type: application/x-www-form-urlencoded

    + Body

            {
              "book_collection": {
                "name": "Book_collection_4"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": {
                "id": "2",
                "type": "book_collections",
                "attributes": {
                  "name": "Book_collection_4"
                },
                "relationships": {
                  "books": {
                    "meta": {
                      "included": false
                    }
                  }
                }
              }
            }

### Update a book collection [PUT /api/v1/book_collections/{id}]

+ Parameters
    + id: `1` (number, required)

+ Request updates the requested book collection
**PUT**&nbsp;&nbsp;`/api/v1/book_collections/1`

    + Headers

            Content-Type: application/x-www-form-urlencoded

    + Body

            {
              "book_collection": {
                "name": "New Book Collection"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": {
                "id": "1",
                "type": "book_collections",
                "attributes": {
                  "name": "New Book Collection"
                },
                "relationships": {
                  "books": {
                    "meta": {
                      "included": false
                    }
                  }
                }
              }
            }

### Delete a book collection [DELETE /api/v1/book_collections/{id}]

+ Parameters
    + id: `1` (number, required)

+ Request destroys the requested book collection
**DELETE**&nbsp;&nbsp;`/api/v1/book_collections/1`

    + Headers

            Content-Type: application/x-www-form-urlencoded

+ Response 204

## Books [/books]


### Get books [GET /api/v1/books]


+ Request returns books
**GET**&nbsp;&nbsp;`/api/v1/books`

    + Headers



+ Response 200

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": [
                {
                  "id": "1",
                  "type": "books",
                  "attributes": {
                    "name": "Book_1"
                  },
                  "relationships": {
                    "author": {
                      "meta": {
                        "included": false
                      }
                    },
                    "book_collection": {
                      "meta": {
                        "included": false
                      }
                    }
                  }
                }
              ]
            }

### Get a book [GET /api/v1/books/{id}]

+ Parameters
    + id: `1` (number, required)

+ Request returns a book
**GET**&nbsp;&nbsp;`/api/v1/books/1`

    + Headers



+ Response 200

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": {
                "id": "1",
                "type": "books",
                "attributes": {
                  "name": "Book_2"
                },
                "relationships": {
                  "author": {
                    "data": {
                      "type": "authors",
                      "id": "1"
                    }
                  },
                  "book_collection": {
                    "data": {
                      "type": "book_collections",
                      "id": "1"
                    }
                  }
                }
              },
              "included": [
                {
                  "id": "1",
                  "type": "authors",
                  "attributes": {
                    "name": "Author_16"
                  },
                  "relationships": {
                    "books": {
                      "meta": {
                        "included": false
                      }
                    }
                  }
                },
                {
                  "id": "1",
                  "type": "book_collections",
                  "attributes": {
                    "name": "Book_collection_16"
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

### Create a book [POST /api/v1/books]


+ Request creates a new book
**POST**&nbsp;&nbsp;`/api/v1/books`

    + Headers

            Content-Type: application/x-www-form-urlencoded

    + Body

            {
              "book": {
                "author_id": "1",
                "name": "New Book"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": {
                "id": "2",
                "type": "books",
                "attributes": {
                  "name": "New Book"
                },
                "relationships": {
                  "author": {
                    "meta": {
                      "included": false
                    }
                  },
                  "book_collection": {
                    "meta": {
                      "included": false
                    }
                  }
                }
              }
            }

### Update a book [PUT /api/v1/books/{id}]

+ Parameters
    + id: `1` (number, required)

+ Request updates the requested book
**PUT**&nbsp;&nbsp;`/api/v1/books/1`

    + Headers

            Content-Type: application/x-www-form-urlencoded

    + Body

            {
              "book": {
                "name": "New Book"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/vnd.api+json; charset=utf-8

    + Body

            {
              "data": {
                "id": "1",
                "type": "books",
                "attributes": {
                  "name": "New Book"
                },
                "relationships": {
                  "author": {
                    "meta": {
                      "included": false
                    }
                  },
                  "book_collection": {
                    "meta": {
                      "included": false
                    }
                  }
                }
              }
            }

### Delete a book [DELETE /api/v1/books/{id}]

+ Parameters
    + id: `1` (number, required)

+ Request destroys the requested book
**DELETE**&nbsp;&nbsp;`/api/v1/books/1`

    + Headers

            Content-Type: application/x-www-form-urlencoded

+ Response 204
