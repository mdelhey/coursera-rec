### Matt Delhey
### Coursera - Intro to Recommender Systems
### Programming Assignment 1

# Read in sample data
df <- read.csv("sample_data.csv", header = FALSE)
names(df) <- c("User.ID", "User.Key", "Movie.ID", "Rating")

simple_asc <- function(x, y) {
    # (x and y) / x
    x_rate <- which(!is.na(x))
    y_rate <- which(!is.na(y))
    
    n_x <- length(x[!is.na(x)])
    n_x_y <- length(intersect(x_rate, y_rate))
    
    return(n_x_y / n_x)
}

advance_asc <- function(x, y) {
    # ((x and y) / x) / ((!x and y) / !x)
    x_norate <- which(is.na(x))
    y_rate <- which(!is.na(y))

    n_nox <- length(x[is.na(x)])
    n_nox_y <- length(intersect(x_norate, y_rate))

    top <- simple_asc(x, y)
    bot <- n_nox_y / n_nox

    return(top / bot)
}
