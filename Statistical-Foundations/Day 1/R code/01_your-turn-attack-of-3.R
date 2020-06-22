
attack3 <- function() {
  attacker <- sort(sample(6, 3, replace = TRUE), decreasing = TRUE)
  defender <- sort(sample(6, 3, replace = TRUE), decreasing = TRUE)
  wins <- sum(attacker > defender) 
  losses <- sum(attacker <= defender) 
  wins - losses
}

n <- 100

set.seed(20200610)
attacks <- replicate(n, attack3())
table(attacks)/n


set.seed(20200610)
attacks <- purrr::rerun(n, attack3())
table(unlist(attacks))/n
