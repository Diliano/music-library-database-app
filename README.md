## Exercise

Follow the Design recipe to test-drive a route `POST /albums` to create a new album:

```
# Request:
POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response (200 OK)
(No content)
```

Your test should assert that the new album is present in the list of records returned by `GET /albums`.

## Challenge

Work in the same project directory.

1. **Test-drive a route `GET /artists`**, which returns the list of artists:
```
# Request:
GET /artists

# Expected response (200 OK)
Pixies, ABBA, Taylor Swift, Nina Simone
```

2. **Test-drive a route `POST /artists`**, which creates a new artist in the database. Your test should verify the new artist is returned in the response of `GET /artists`.

```
# Request:
POST /artists

# With body parameters:
name=Wild nothing
genre=Indie

# Expected response (200 OK)
(No content)

# Then subsequent request:
GET /artists

# Expected response (200 OK)
Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing
```

3. **Create a sequence diagram** explaining the behaviour of your program when a request is sent to `POST /artists`. Make sure your diagram all includes the following:
    * The HTTP Client
    * The HTTP Request and the data it contains
    * The HTTP Response and the data it contains
    * The Application class (`app.rb`)
    * The Repository class (`artist_repository.rb`)
    * The Database

## POST /artists Sequence Diagram

![](/post_artists_sequence_diagram.png)