one.card <- RV(c(0,1), probs=c(0.9,.1))
(sequentially <- SofIID(one.card, n=2))
(together<- RV(c(0,1), probs = c(0.8, 0.2)))
E(sequentially)
E(together)

V(sequentially)
V(together)
