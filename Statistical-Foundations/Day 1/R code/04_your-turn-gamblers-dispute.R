#one.die <- RV(1:6, probs = 1/6)
#pair <- iid(one.die, n=2)
doublesix <- RV(c(0,1), probs=c(35/36, 1/36))

twentyfour <- SofIID(doublesix, n = 24, fractions = FALSE)
P(twentyfour >= 1)

chevalier <- RV(c(-1,1,1,1,1,1,1,1,1), probs = probs(twentyfour))
E(chevalier)
