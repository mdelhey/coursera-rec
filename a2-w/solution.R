### Matt Delhey
### Coursera - Intro to Recommender Systems
### Writing Assignment 2
### List top 5 movies for each metric
library(stringr)

# Read in data
df <- read.csv("data.csv")

# Clean movie names/ids
movie_names <- names(df)[2:length(names(df))]
movie_ids_raw <- str_extract(movie_names, "X[0-9]+")
movie_ids <- str_replace(movie_ids_raw, "X", "")
names(df)[2:length(names(df))] <- movie_ids

### Mean movie rating
q1 <- apply(df[, -1], 2, mean, na.rm = TRUE)
q1 <- head(sort(q1, decreasing = TRUE), 5)
q1_out <- names(q1)
write.table(q1_out, "q1.csv", col.names = FALSE, row.names = FALSE, quote = FALSE)

### % of ratings 4+ (out of DEFINED ratings)
four_or_higher <- function(x) {
    x <- x[!is.na(x)]
    n <- length(x)
    n_4 <- length(x[x >= 4])
    p <- n_4/n
    return(p)
}
q2 <- apply(df[, -1], 2, four_or_higher)
q2 <- head(sort(q2, decreasing = TRUE), 5)
q2_out <- names(q2)
write.table(q2_out, "q2.csv", col.names = FALSE, row.names = FALSE, quote = FALSE)

### Rating count (# of ratings per movie)
q3 <- apply(df[, -1], 2, function(i) length(i[!is.na(i)]))
q3 <- head(sort(q3, decreasing = TRUE), 5)
q3_out <- names(q3)
write.table(q3_out, "q3.csv", col.names = FALSE, row.names = FALSE, quote = FALSE)

### Association with Star Wars: Episode IV - A New Hope (1977)
starwars_asc <- function(x, starwars) {
    n_x <- length(x[!is.na(x)])
    rate_starwars <- which(!is.na(starwars))
    rate_x <- which(!is.na(x))
    n_starwars <- length(intersect(rate_starwars, rate_x))
    return(n_starwars/n_x)
}
q4 <- apply(df[, -1], 2, starwars_asc, starwars = df[, 2])
q4 <- head(sort(q4, decreasing = TRUE), 6)
q4_out <- names(q4)[2:6]  # Remove A New Hope from results
write.table(q4_out, "q4.csv", col.names = FALSE, row.names = FALSE, quote = FALSE)
