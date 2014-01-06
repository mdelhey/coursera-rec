### Matt Delhey
### Coursera - Intro to Recommender Systems
### Programming Assignment 1

# Read in user and movie data
ratings <- read.csv("ratings.csv", header = FALSE)
movies <- read.csv("movies.csv", header = FALSE)
names(ratings) <- c("User.ID", "Movie.ID", "Rating")
names(movies) <- c("Movie.ID", "Movie.Title")

simple_asc <- function(x, y) {
    # x: id's of users who rated movie X
    # y: id's of users who rated movie Y
    # score = (x and y) / x
    n_x <- length(x)
    n_x_y <- length(intersect(x, y))
    return(n_x_y / n_x)
}

y <- ratings[ratings$Movie.ID == 603, ]$User.ID
x <- ratings[ratings$Movie.ID == 11, ]$User.ID

x1 <- ratings[ratings$Movie.ID == 11, ]$Rating
y1 <- sapply(ratings$Rating, simple_asc, x)

advance_asc <- function(x, y, users) {
    # x: id's of users who rated movie X
    # y: id's of users who rated movie Y
    # score = ((x and y) / x) / ((!x and y) / !x)
    x_norate <- which(is.na(x))
    y_rate <- which(!is.na(y))

    n_nox <- nusers - length(x)
    n_nox_y <- length(intersect(x_, y_rate))

    top <- simple_asc(x, y)
    bot <- n_nox_y / n_nox

    return(top / bot)
}
