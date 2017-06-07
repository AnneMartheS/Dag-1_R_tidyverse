#hent opp datasett: 

library(tidyverse)
gapminder <- read_csv("Data/gapminder-FiveYearData.csv")
#pipe-konsept: lar oss stringe flere data sammen. Pipe-symbol: 

#hvordan gjenta tekststring flere ganger: ctrl+shift+M
rep("This is an example", times=3)


"This is an example" %>% rep(times=3)

#begrense dataen til kun x kolonner: Bestemmer hva en data skal hete. Begrense datasettet med select (variabel, variabel, variabel)
year_country_gdp <- select(gapminder, year, country,gdpPercap)  
year_country_gdp
head(year_coundtry_gdp)
head(year_country_gdp)

year_country_gdp <- gapminder %>% select(year, country,gdpPercap)
head(year_country_gdp)


# en == betyr at hver gang året er 2002 tar man med det, skal raden tas med, ellers forkaste. Enkel = er en oppgave 
#
gapminder %>% 
  filter (year==2002) %>% 
  ggplot(mapping=aes(x=continent,y=pop)) +
  geom_boxplot()

year_country_gdp_euro <-  gapminder %>% 
  filter (continent=="Europe") %>%
  select(year, country,gdpPercap)

year_country_gdp_euro

#for Norge: kunne kalt den noe annet enn year_country_gdp_euro..  
year_country_gdp_euro <-  gapminder %>% 
  filter (country=="Norway") %>%
  select(year,lifeExp,gdpPercap)

year_country_gdp_euro

#gapminder er datasettet vi jobber i:) gruppe etter ulike faktorer. 

gapminder %>% 
  group_by(continent)

#laget flere grupper: hvordan kalkulere gj.snittet til disse gruppene: 
gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))

gapminder %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))

gapminder %>% 
  group_by(country) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap)) %>% 
  ggplot(mapping=aes(x=continent,y=mean_gdpPercap)) +
  geom_boxplot()

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap)) %>% 
  ggplot(mapping=aes(x=continent,y=mean_gdpPercap)) +
  geom_point()

#finne sstørste og minste gj.snittsverdi innen en gruppe som du sorterer. Her land i Asia som er størst eller minst verdi på gj.snittlig levealder
gapminder %>% 
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>% 
  filter(mean_lifeExp==min(mean_lifeExp)|mean_lifeExp==max(mean_lifeExp))

#gjøre det samme - bare med å lage boxplot i stede. Visualisere det samme som beregnes over: 
gapminder %>% 
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>% 
  ggplot(mapping=aes(x=country,y=mean_lifeExp))+
  geom_point()+
  order()+
  coord_flip()

gapminder %>% 
  filter(continent=="Asia") %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>% 
  ggplot(mapping=aes(x=country,y=mean_lifeExp))+
  geom_point()+
  coord_flip()

#transform en variable til en annen
gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9) %>%
  head()

gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9) %>%
  group_by(continent,year) %>% 
  summarize(mean_gdp_billion=mean(gdp_billion))

#visualisere livsexp for hele verden i ulike farger 



library(maps)

map_data("world") %>% 
  head()

#gi en variabel nytt navn:
map_data("world") %>% 
  rename(country=region) %>%

  #merge to datasett sammen: 

 gapminder_country_summary<-gapminder %>%
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp))

map_data("world") %>% 
  rename(country=region) %>% 
  left_join(gapminder_country_summary,by="country") %>% 
  ggplot()+
  geom_polygon(aes(x=long,y=lat,group=group,fill=mean_lifeExp))+
  scale_fill_gradient(low="blue",high="red")+
  coord_equal()

