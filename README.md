[![Build Status](https://travis-ci.org/jdecastroc/reddit-music-api.svg?branch=master)](https://travis-ci.org/jdecastroc/music-discoverer)[![codecov](https://codecov.io/gh/jdecastroc/reddit-music-api/branch/master/graph/badge.svg)](https://codecov.io/gh/jdecastroc/reddit-music-api)
# Reddit Music API

Reddit Music API is a project done in order to learn deeply about Rails framework focusing on how to create a simple API. The application allows the user to get a list with youtube resources from their favorites [Reddits](www.reddit.com).

# What did I learn
  - The diferences between the creation of a normal Rails application and a [API-only Rails application](http://edgeguides.rubyonrails.org/api_app.html) available with the new version of Rails 5
  - Good practises oriented to the creation of APIs within Rails like separating the functions/tests depending of the version of the API and how to respect the framework folder structure
  - A better knowledge about the ruby modules and error control
  - How to do simple API-oriented tests with Rspec keeping in mind the helpers
  - The beneficts of follow an API format standart (in this case [JSend](http://labs.omniti.com/labs/jsend)) 

# Request Example
This method returns a JSON object with the youtube resources

Example: https://reddit-music-api.herokuapp.com/api/v1/r/jpop+kpop?songs=30&random=true&order=newest
## Parameters
| Name | Type | Description |
| ------ | ------ | ------ |
| reddit | (PATH_PARAM) String | The reddits from which the user want to get the youtube resources (max of 3) |
| songs* | (REQUEST_PARAM) int | The number of youtube resources of the playlist | 
| random* | (REQUEST_PARAM) boolean | Indicate whether the resources of the different reddits are going to be mixed |
| order* | (REQUEST_PARAM) String | Indicate whether the playlist is going to get the newest resources or random (newest/random) |
| last* | (REQUEST_PARAM) int | ONLY if newest is set. Set the songs per reddit start form $last (skip the first $last songs) |
 \* Optional parameters
 
 ## Response examples
 ### When random is false
 ```sh
{
  "status": "success",
  "songs": 6,
  "random": "false",
  "order": "newest",
  "last": 0,
  "data": {
    "reddits": [
      {
        "name": "https://www.reddit.com/r/jpop",
        "resources": [
          {
            "url": "ph68ESn81SI",
            "source": "youtube",
            "name": "Charisma.com one-man tour 2017\" not not me. ' \"Final performances than, live video of the show off the encore\" Arasa Dolly Min \"."
          },
          {
            "url": "zo2YakKCwIk",
            "source": "youtube",
            "name": "[PV] E-girls - Love ☆ Queen"
          },
          {
            "url": "cs5gmt10h-0",
            "source": "youtube",
            "name": "Charisma.com / Arasa Dolly Min <cotton professional 2 Ver.> - YouTube"
          }
        ]
      },
      {
        "name": "https://www.reddit.com/r/jazz",
        "resources": [
          {
            "url": "yEi_xYKI7Gw",
            "source": "youtube",
            "name": "The Dave Brubeck Quartet - Jazz Impressions Of Japan"
          },
          {
            "url": "4hYYgz-AJKU",
            "source": "youtube",
            "name": "Harry Connick Jr. Rhythmic Displacement Explanation"
          },
          {
            "url": "cgAwCNaqdhU",
            "source": "youtube",
            "name": "福居良 (Ryō Fukui) - Baron Potato Blues [1977]"
          }
        ]
      }
    ]
  }
}
```
### When random is true
 ```sh
{
  "status": "success",
  "songs": 6,
  "random": "true",
  "order": "newest",
  "last": 0,
  "data": {
    "reddits": [
      "jpop",
      "jazz"
    ],
    "resources": [
      {
        "url": "cgAwCNaqdhU",
        "source": "youtube",
        "name": "福居良 (Ryō Fukui) - Baron Potato Blues [1977]"
      },
      {
        "url": "4hYYgz-AJKU",
        "source": "youtube",
        "name": "Harry Connick Jr. Rhythmic Displacement Explanation"
      },
      {
        "url": "zo2YakKCwIk",
        "source": "youtube",
        "name": "[PV] E-girls - Love ☆ Queen"
      },
      {
        "url": "cs5gmt10h-0",
        "source": "youtube",
        "name": "Charisma.com / Arasa Dolly Min <cotton professional 2 Ver.> - YouTube"
      },
      {
        "url": "ph68ESn81SI",
        "source": "youtube",
        "name": "Charisma.com one-man tour 2017\" not not me. ' \"Final performances than, live video of the show off the encore\" Arasa Dolly Min \"."
      },
      {
        "url": "yEi_xYKI7Gw",
        "source": "youtube",
        "name": "The Dave Brubeck Quartet - Jazz Impressions Of Japan"
      }
    ]
  }
}
```

# Conclusion
It has been a very good experience and I would like to continue improving it by finishing some functions and tests and adding new like parse soundcloud resources or add new user-oriented functions. It was a good start to understand how to make an API with Rails and I liked how RSpec works with the test development.
