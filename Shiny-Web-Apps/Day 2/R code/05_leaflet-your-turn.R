oregon <- c(-123.27944, 44.56378)
isu <-c(-93.64647,  42.02662) 
virginia <- c(-78.50798, 38.03355)

leaflet() %>%
  addProviderTiles(provider="Esri") %>%
  setView(lng = oregon[1], lat = oregon[2], zoom=16)

leaflet() %>%
  addProviderTiles(provider="CartoDB") %>%
  setView(lng = virginia[1], lat = virginia[2], zoom=16)

leaflet() %>%
  addProviderTiles(provider="CartoDB.Voyager") %>%
  setView(lng = isu[1], lat = isu[2], zoom=16)
