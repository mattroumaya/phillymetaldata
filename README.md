# phillymetaldata
get data from phillymetal.net

[phillymetal.net](www.phillymetal.net) is a website that lists metal, punk, hardcore, and generally heavy shows in the philadelphia area.

The `{phillymetaldata}` package pulls data for all shows that have ever been listed on phillymetal.net.

# install
```
devtools::install_github('mattroumaya/phillymetaldata`)
```

## get data

To get all shows ever listed, simply run: 

```
data <- phillymetaldata::get_data()
```

To get shows that you can possibly attend (i.e., everything today and in the future), run: 

```
data <- phillymetaldata::get_data(upcoming_shows_only = TRUE)
```
