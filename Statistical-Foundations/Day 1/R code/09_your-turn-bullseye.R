library(discreteRV)

shot <- RV(c(1,0), probs = c(1/10, 9/10))
(three.shots <- SofIID(shot, n=3))
E(three.shots)
V(three.shots)