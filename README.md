## Test-driving routes - Exercise

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

## Testing-driving routes - Challenge

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

## Using ERB to return dynamic HTML - Exercise

In the project `music_library_database_app`.

Test-drive and implement a `GET /albums/:id` route so it returns the HTML content for a single album:

```html
<!-- Example for GET /albums/1 -->

<html>
  <head></head>
  <body>
    <h1>Doolittle</h1>
    <p>
      Release year: 1989
      Artist: Pixies
    </p>
  </body>
</html>

<!-- Example for GET /albums/2 -->

<html>
  <head></head>
  <body>
    <h1>Surfer Rosa</h1>
    <p>
      Release year: 1988
      Artist: Pixies
    </p>
  </body>
</html>
```

## Using ERB to return dynamic HTML - Challenge

In the project `music_library_database_app`.

Test-drive and update the `GET /albums` route so it returns the list of albums as an HTML page:

```html
<!-- GET /albums -->

<html>
  <head></head>
  <body>
    <h1>Albums</h1>

    <div>
      Title: Doolittle
      Released: 1989
    </div>

    <div>
      Title: Surfer Rosa
      Released: 1988
    </div>

    <!-- ... -->
  </body>
</html>
```

_(Don't forget to run the app using `rackup`)._

Use your web browser to access the page.

## Using Links - Exercise

Test-drive and implement the following change to the `music_library_database_app` project:

The page returned by `GET /albums` should contain a link for each album listed. It should link to `/albums/:id`, where `:id` is the corresponding album's id.

Run the server and make sure you can navigate, using your browser, from the albums list page to the single album page.