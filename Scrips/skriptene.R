#For å åpne tidyverse package vi trykker: 

library("tidyverse")

gapminder <- read_csv(file = "Data/gapminder-FiveYearData.csv")

gapminder
#lage et skript som lager et plot: første linje er dataen og datasettet, setter inn + for å kombinere flere linjer. Aner ikke hvorfor. aes er aestethic mapping, setter deretter inn x og y koordinatene. 
#ulike måter å se på dataen: deskriptiv statesikk: 
ggplot(data = gapminder) + 
  geom_point(mapping = aes(x = gdpPercap, y = life

#flere farger/ data                           
ggplot(data = gapminder) + 
  geom_jitter(mapping = aes(x = gdpPercap, y = lifeExp, color = continent))
#samme plot, men la til populasjon og log: trnseformerte dataen ved hjelp av log. 
ggplot(data = gapminder) + 
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp, color = continent, size=pop))                                                      

ggplot(data = gapminder) + 
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp),
             alpha=0.1, size=2, color="blue")                                                      

ggplot(data = gapminder) + 
  geom_line(mapping = aes(x = log(gdpPercap), y = lifeExp,
             group=country, color= continent))

ggplot(data = gapminder) + 
  geom_line(mapping = aes(x = year, y = lifeExp,
                          group=country, color= continent))

#boxplot
ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = continent, y = lifeExp))

#kombinere flere typer visualiseringer i samme bildet: Husk + for å knytte sammen flere kommandoer
ggplot(data = gapminder) + 
  geom_jitter(mapping=aes(x = continent, y = lifeExp, color= continent)) +
  geom_boxplot(mapping = aes(x = continent, y = lifeExp, color=continent))

ggplot(data = gapminder) + 
  geom_boxplot(mapping = aes(x = continent, y = lifeExp, color=continent)+
  geom_jitter(mapping=aes(x = continent, y = lifeExp, color= continent))

# kan også gjør slik:
ggplot(data = gapminder, 
       mapping=aes(x = continent, y = lifeExp, color= continent)) +
    geom_jitter()+
    geom_boxplot()
  


#jidder: sprer dataen litt. 0.5 smi transperent. Endres dette tallet til 0.1 blir dottene lysere.  
ggplot(data = gapminder, 
       mapping=aes(x = log(gdpPercap), y = lifeExp, color= continent)) +
  geom_jitter(alpha=0.5)+
  geom_smooth(method = "lm")

#hvis ønsker en linje (modellen), men ønsker fremdeles fargene. Må da sjule fargen.Kutt den ut av hovedfunksjoner. Legg den inn der hvor du ønsker at linjen skal ligge.  

ggplot(data = gapminder, 
       mapping=aes(x = log(gdpPercap), y = lifeExp)) +
  geom_jitter(mapping=aes(color= continent),alpha=0.5)+ 


#får frem ulike plots - splitter dataen  
ggplot(data = gapminder, mapping=aes(x=gdpPercap, y= lifeExp)) + 
  geom_point() +
  geom_smooth()+
  scale_x_log10()+
  facet_wrap(~ continent)

#hvis annen faktor: eks år. method=linjær modell = "lm". Hvis ikke vil R lage linjene ikke linjære. facet_wrap splitter 
ggplot(data = gapminder, mapping=aes(x=gdpPercap, y= lifeExp)) + 
  geom_point() +
  geom_smooth(method="lm")+
  scale_x_log10()+
  facet_wrap(~ year)

#Gått gjennom ggplot: hvordan får frem ulike plots etc

#FILTER: eks få frem data fra kun et år. Dataen består nå av:

filter(gapminder, year==2007) 
#legg dette inn i ggplot. Men legger ikke inn noe på y-aksen. R sier likevel at noe skal på Y og mener da at y skal ha et nummer.geom_bar legger inn nummer på y aksen automatisk.                                  

ggplot(data=filter(gapminder, year==2007))+
  geom_bar(mapping =aes(x=continent))

#hvis skriver ut skriptet
ggplot(data=filter(gapminder, year==2007))+
  geom_bar(mapping =aes(x=continent), stat = "count")

filter(gapminder, year==2007, continent=="Oceania")

#stat ="identity" betyt "ikke gjør noe med dataen"

ggplot(data=filter(gapminder, year==2007, continent=="Oceania"))+
  geom_bar(mapping=aes(x=country, y=pop),stat = "identity")

ggplot(data=filter(gapminder, year==2007, continent=="Asia"))+
  geom_col(mapping=aes(x=country, y=pop))

#flippe koordinatene rundt
ggplot(data=filter(gapminder, year==2007, continent=="Asia"))+
  geom_col(mapping=aes(x=country, y=pop))+
  coord_flip()


ggplot(data = gapminder, mapping=aes(x=gdpPercap, y= lifeExp, 
                                     color=continent)) + 
  geom_point() +
  scale_x_log10()+
  facet_wrap(~ year)


ggplot(data = gapminder, mapping=aes(x=gdpPercap, y= lifeExp, 
                                     color=continent, size==pop/10^6)) + 
  geom_point() +
  scale_x_log10()+
  facet_wrap(~ year)

#lage plotten fin:
ggplot(data = gapminder, mapping=aes(x=gdpPercap, y= lifeExp, 
                                     color=continent, size==pop/10^6)) + 
  geom_point() +
  scale_x_log10()+
  facet_wrap(~ year)+
  labs(title="Life Expectancy vs GDP per capita over time")

ggplot(data = gapminder, mapping=aes(x=gdpPercap, y= lifeExp, 
                                     color=continent, size=pop/10^6)) + 
  geom_point() +
  scale_x_log10()+
  facet_wrap(~ year)+
  labs(title="Life Expectancy vs GDP per capita over time", 
       subtitle= "de siste årene har levealderen til de fleste land i verden steget",
       caption="source:Gapminder fundation..lala")

ggplot(data = gapminder, mapping=aes(x=gdpPercap, y= lifeExp, 
                                     color=continent, size=pop/10^6)) + 
  geom_point() +
  scale_x_log10()+
  facet_wrap(~ year)+
  labs(title="Life Expectancy vs GDP per capita over time", 
       subtitle= "de siste årene har levealderen til de fleste land i verden steget",
       caption="source:Gapminder fundation..lala", 
       x="GDP per capita, in 000 USD", 
       y="Life Expectancy in years", 
       color="Continent",
       size="populasjon, i millioner")

#lagre filer: 
ggsave("my_fancy_plot.png")


