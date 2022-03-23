# README - Archived
This was never used. Today (March 2022) holdings for Library Search are retrieved directly from Solr. 

---

This is the repository for the get_holdings API used by Library Search. It gathers data from Alma and does further processing to get the proper information and proper form for search to consume.

## To Set up for Development

1. Clone the github repo
`$ git clone git@github.com:mlibrary/get_holdings.git`
2. Set up the environment variables. 
```bash
$ mkdir -p .env/development
$ vi .env/development/web
```
```ruby
#.env/development/web
ALMA_API_KEY='YOURAPIKEY'
ALMA_API_HOST='https://api-na.hosted.exlibrisgroup.com'
```	
3. Build the web container 
```bash
$ docker-compose build web
```

4. Run the web container
```bash
$ docker-compose up
```

## Tests
For rspec tests run:
```bash
$ docker-compose run web bundle exec rspec
```

