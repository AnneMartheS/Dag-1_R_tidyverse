# GAPMINDER PLUS 
download.file(url = "https://raw.githubusercontent.com/dmi3kno/SWC-tidyverse/master/data/gapminder_plus.csv", 
              destfile = "Data/gapminder_plus.csv")

#R er sensitiv for store og små bokstaver
#ibrary(..) betyr at du går inn i den mappen 

library("tidyverse")


gapminder_plus<- read.csv(file="Data/gapminder_plus.csv")

#åpne mappen for å se på filene: 
gapminder_plus



#7 land som har mer enn 200 mill døde i 2007
#filter afrika - begrense til dette 
#mutate nr of baby dead multiply pop og inf mort
#filter den nye kollonnen kun 2007
#filter()
#filter infant mortalit nr of babyes -populasjon 

#filter(gapminder, year==2007) 
#filter(gapminder, year==2007, continent=="Oceania")
#                                    color=continent, size=pop/10^6)) + 
#geom_point() +
  scale_x_log10()+
  facet_wrap(~ year)+
  labs(title="Life Expectancy vs GDP per capita over time", 
       subtitle= "de siste årene har levealderen til de fleste land i verden steget",
       caption="source:Gapminder fundation..lala", 
       x="GDP per capita, in 000 USD", 
       y="Life Expectancy in years", 
       color="Continent",
       size="populasjon, i millioner")

  
  
  filter(gapminder, year==2007, continent=="Oceania")
  
  #stat ="identity" betyt "ikke gjør noe med dataen"

#ggplot(data=filter(gapminder, year==2007, continent=="Oceania"))+
    geom_bar(mapping=aes(x=country, y=pop),stat = "identity")
  
#ggplot(data=filter(gapminder, year==2007, continent=="Asia"))+
    geom_col(mapping=aes(x=country, y=pop))

    
#== mer/helt likt , 1e3=kort for 10^3

#inne_joint etc: se hvordan se på to ulike datasett. full_join(x,y)- to datasaett settes sammen, modifisert datsaett vil alltid være x, det orginale vil være y.     
    
#oppgave: lage en ny kollonne, beregnet ut fra annen informasjon i plottet + kun 2007 + kun afrika 
gapminder_plus %>% 
  filter(year==2007,continent=="Africa") %>%
  mutate(babiesDead=infantMort*pop/10^3) %>% 
  filter(babiesDead>2e6) %>% 
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  mutate(babiesDead=infantMort*pop/10^3)
  
#oppgave videre: lage grafer pr land . med kun det høyste landet betegnet. For at gather skal fungere må man i parantes skrive både key=(navnet på variablene du skal bruke) values=(kollonnen). 
#kan sjekke du hva om skjer med dataen select(year, country). Hvis vil se på denne dataen nærmere etter å ha brukt
#gather (key=variables, values=something/navn du kaller de nye vdariablene dine), kan bruke Viewer() %>%  etter hele koden/skriptet
#c() er det samme som select()- velg å se på eks contries, med minus forran tar du bort eks contries
gapminder_plus %>% 
  filter(year==2007,continent=="Africa") %>%
  mutate(babiesDead=infantMort*pop/10^3) %>% 
  filter(babiesDead>2e6) %>% 
  select(-continent) %>% 
  left_join(gapminder_plus) %>% 
  mutate(babiesDead=infantMort*pop/10^3) %>% 
  gather(key= variables, value= values, c(fert,infantMort, babiesDead, gdpPercap, pop, lifeExp))


gapminder_plus %>% 
  filter(year==2007,continent=="Africa") %>%
  mutate(babiesDead=infantMort*pop/10^3) %>% 
  filter(babiesDead>2e6) %>% 
  select(country) %>% 
  left_join(gapminder_plus)%>% 
  mutate(babiesDead=infantMort*pop/10^3,
         gdp_bln=gdpPercap*pop/1e9, 
         pop_mln=pop/1e6) %>% 
  select(-continent) %>% 
  gather(key= variables, value= values, -c(country, year))

#opgave: lage plott av dataen:
gapminder_plus %>% 
  filter(year==2007,continent=="Africa") %>%
  mutate(babiesDead=infantMort*pop/10^3) %>% 
  filter(babiesDead>2e6) %>% 
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  mutate(babiesDead=infantMort*pop/10^3,
         gdp_bln=gdpPercap*pop/1e9, 
         pop_mln=pop/1e6) %>% 
  select(-c(continent, pop, babiesDead)) %>% 
  gather(key= variables, value= values, -c(country, year)) %>% 
  ggplot()+
  geom_line(mapping=aes(x=year, y=values, color=country))+
  facet_wrap(~variables, scales="free_y")
#Gjøre diverse endringer til grafene i bildet med labs()

gapminder_plus %>% 
  filter(year==2007,continent=="Africa") %>%
  mutate(babiesDead=infantMort*pop/10^3) %>% 
  filter(babiesDead>2e6) %>% 
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  mutate(babiesDead=infantMort*pop/10^3,
         gdp_bln=gdpPercap*pop/1e9, 
         pop_mln=pop/1e6) %>% 
  select(-c(continent, pop, babiesDead)) %>% 
  gather(key= variables, value= values, -c(country, year)) %>% 
  ggplot()+
  geom_line(mapping=aes(x=year, y=values, color=country))+
  facet_wrap(~variables, scales="free_y")+
  labs(title="Dette er et forsøk", subtitle="Vi prøver å endre subtitle", caption="caption og kilder",
       y=NULL, 
       x="Year")+
  theme_dark()

#med ulike temaer. kan bare trykke inn "theme". skriv inn theme i hjelpe feltet, får oversikt. theme er det mest fleksible.  
#nb. når bruker ggplot()- hvis ikke skriver noe inne i () vil det bety ggplot(data=.)- data fra %>% vil plasseres der det står .

gapminder_plus %>% 
  filter(year==2007,continent=="Africa") %>%
  mutate(babiesDead=infantMort*pop/10^3) %>% 
  filter(babiesDead>2e6) %>% 
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  mutate(babiesDead=infantMort*pop/10^3,
         gdp_bln=gdpPercap*pop/1e9, 
         pop_mln=pop/1e6) %>% 
  select(-c(continent, pop, babiesDead)) %>% 
  gather(key= variables, value= values, -c(country, year)) %>% 
  ggplot()+
  geom_line(mapping=aes(x=year, y=values, color=country))+
  facet_wrap(~variables, scales="free_y")+
  labs(title="Dette er et forsøk", subtitle="Vi prøver å endre subtitle", caption="caption og kilder",
       y=NULL, 
       x="Year")+
  theme_bw()+
  theme(legend.position = "none")

# denne fungere ikke helt, og aner ikke hva den skal gjøre. 
gapminder_plus %>% 
  filter(year==2007,continent=="Africa") %>%
  mutate(babiesDead=infantMort*pop/10^3) %>% 
  filter(babiesDead>2e6) %>% 
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  mutate(babiesDead=infantMort*pop/10^3,
         gdp_bln=gdpPercap*pop/1e9, 
         pop_mln=pop/1e6) %>% 
  select(-c(continent, pop, babiesDead)) %>% 
  gather(key= variables, value= values, -c(country, year)) %>% 
  ggplot()+
  geom_text (data = . %>% filter(year==2007) group_by(variables) %>% 
               mutate(max_value=max(values)) %>% 
               aes(x=year, y=values, label=country, color=country))+
  geom_line(mapping=aes(x=year, y=values, color=country))+
  facet_wrap(~variables, scales="free_y")+
  labs(title="Dette er et forsøk", subtitle="Vi prøver å endre subtitle", caption="caption og kilder",
       y=NULL, 
       x="Year")+
  theme_bw()+
  theme(legend.position = "none")



