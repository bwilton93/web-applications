# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

POST
```html
<!-- Response when the post is found: 200 OK -->
<!-- no content -->
```

GET
```html
<!-- Response when the post is found: 200 OK -->
<html>
  <head></head>
  <body>
    <h1>Albums</h1>
    <div>
      <ul>
        <li>Doolittle</li>
        <li>Surfer Rosa</li>
        <li>Waterloo</li>
        <li>Super Trouper</li>
        <li>Bossanova</li>
        <li>Lover</li>
        <li>Folklore</li>
        <li>I Put a Spell on You</li>
        <li>Baltimore</li>
        <li>Here Comes the Sun</li>
        <li>Fodder on My Wings</li>
        <li>Ring Ring</li>
        <li>Voyage</li>
      </ul>
    </div>
  </body>
</html>
```


## 3. Write Examples

_Replace these with your own design._

```
# Request:

POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response:

Response for 200 OK
```

```
# Request:

GET /albums

# Expected response:

Response for 200 OK

list of all albums
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /albums with parameters" do
    it 'returns 200 OK' do
      response = post('/albums',title:'Voyage',release_year:2022,artist_id:2)

      expect(response.status).to eq(200)
      expect(reponse.body).to eq ""

      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include('Voyage')
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.


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