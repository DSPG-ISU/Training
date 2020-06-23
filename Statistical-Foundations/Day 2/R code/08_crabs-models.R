crabs <- read.csv("http://ggobi.org/book/data/australian-crabs.csv")

####
m3b <- lm(RW ~ sex + CL:sex, data = crabs)
summary(m3b)

new.data = data.frame(sex="Male", CL = 35)
predict(m3b, newdata = new.data, interval = "confidence")
predict(m3b, newdata = new.data, interval = "prediction")
