library(dplyr)


### Randomized assignment
# Create data frame and assign baseline variables
df <- data.frame(Y.without.X = rnorm(1000), X = sample(c(0,1), 1000, replace = TRUE)) %>%
  mutate(Y.with.X = Y.without.X + 1) %>%
  # Now assign who actually gets X and assign the values of Y
  mutate(Observed.Y = ifelse(X == 1, Y.with.X, Y.without.X))

# And see what effect our experiment suggests X has on Y
df %>% group_by(X) %>% summarize(Y = mean(Observed.Y))

### Non-Randomized assignment
# Create data frame and assign baseline variables
df <- data.frame(Z = runif(10000)) %>%
  mutate(Y.without.X = rnorm(10000) + Z) %>%
  mutate(Y.with.X = Y.without.X + 1) %>%
  # Now assign who actually gets X and assign the values of Y
  mutate(X = Z > 0.7, Observed.Y = ifelse(X == 1, Y.with.X, Y.without.X))

# And see what effect we estimate for X on Y
df %>% group_by(X) %>% summarize(Y = mean(Observed.Y))

#DO YOURSELF: Properly model the process to compare apples to apples...
