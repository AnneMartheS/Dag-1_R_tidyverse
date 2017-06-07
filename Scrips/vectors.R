#Vectors: kan være et enkelt nummer, eks x, <-assignment operator

x <- 5*6

is.vector(x)
length(x)


x[2]<-31
x
x[5]<-44
x
x[9]
x[10]

x<-1:4
x
x<-1:10
x
x<-1:4
x

y<-x^2
y

#recycling: adderer basert på plasseringen. En måte og håndtere NA. MEn - må være obs på NA. R vil omgjøre alt som tucher NA, til NA

x<-1:5
y<- 3:7

x+y


z<- y[-5]
z
x+z
z^x

#c er lik "combination"
str(c("Hello", "Workshop", "participants!"))

c(9:11, 200, x)
#vil man se på strukture i disse dataen: 
str(c(9:11, 200, x))

c("something", pi, 2:4, pi<3)
str(c("something", pi, 2:4, pi<3))

#hva betyr egentlig str()?

#
w<- rnorm(10)
seq_along(w)
w
#hvisbare interssert i neg nummer: 
which(w<0)
#gir deg plasseringen til disse tallene (neg)


w[which(w<0)]
# henter ut faktiske tallene. 
w[w<0]
w[-c(2,5)]

#Hva er LIST: lar oss spesifisere navn på alle elemenetene. 

# hvis heller vil ha informasjonen listevis. 
list("Something", pi, 2:4, pi>3)
str(list("Something", pi, 2:4, pi>3))

x<-list(vegetable="cabbage", 
     number= 2:4, 
     telling=pi>3)
#når R denne, vil man få en liste. Hvis vil strukturere denne: skriv str()
str(x)

#[enkel av disse gir deg informasjon med resten av listen] [[]]to inni hverandre vil ta bort pakken, og kun gi informasjonen..

x$vegetable
list(x$vegetable)
x$vegetable

x<-list (vegetable=list("cabbage", "kulrot", "spinat"), 
         number = list(c(pi, 0, 2,14, NA)), 
         series= list (list(2:4, 3:5)),
         telling=pi<3)
str(x)
str(x$vegetable)
#-----------
#lage en komplisert modell: 
mod<- lm(lifeExp~gdpPercap, data=gapminder_plus)
mod
str(mod)

#finne en spesiell variabel
mod[8]
str(mod[[8]])
str(mod[["df.residual"]])
str(mod$df.residual)

#finne en variabel
mod$qr, 
str(mod$qr)
str(mod$qr$qr)

mod$qr$qr [1,1]

#summerize avr LifeExp by kontinent 

gapminder_plus %>% 
  group_by(continent) %>% 
  summarise(mean_le=mean(lifeExp), 
             min_le=min(lifeExp), 
             max_le=max(lifeExp)

#hvordan få frem mer graf: 

gapminder_plus %>% 
  ggplot()+
  geom_line(mapping=aes(x=year, y=lifeExp, color=continent, group=country))+
  geom_smooth(mapping=aes(x=year, y=lifeExp), method="lm", color="black", )+
  facet_wrap(~continent)

#nest: 
by_country<-gapminder_plus %>% group_by(continent, country) %>% 
  nest()

str(by_country$data)

by_country$data

#map() lar deg apply a function to a spesific list. Map(list, function)

map(1:3, sqrt)

#~ de kaller dette tilda.. 

#hente frem data på nytt: 
library(purrr)


#lage en ny kollone


model_by_country<-by_country

model_by_country<-by_country %>%
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.x))) %>% 
  mutate(summr=map(model,broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% 
  ggplot()+
  geom_jitter(mapping=aes(x=continent, y=r.squared))

by_country %>%
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.x))) %>% 
  mutate(summr=map(model,broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% filter(r.squared<0.6) %>% 
  select(country)


by_country %>%
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.x))) %>% 
  mutate(summr=map(model,broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% filter(r.squared<0.5) %>% 
  select(country) %>% left_join(gapminder_plus) %>% 
  ggplot()+
  geom_line(mapping=aes(x=year, y=lifeExp, color=country, group=country))

#lifeExp avhengig av gdpPercap - gjør penger at du kan leve lengre? 

by_country %>%
  mutate(model=purrr::map(data, ~lm(lifeExp~year, data=.x))) %>% 
  mutate(summr=map(model,broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% filter(r.squared<0.5) %>% 
  select(country) %>% left_join(gapminder_plus) %>% 
  ggplot()+
  geom_line(mapping=aes(x=year, y=lifeExp, color=country, group=country))

#se på dataen først: scatterplot

gapminder_plus %>% ggplot()+
  geom_point(mapping=aes(x=gdpPercap, y=lifeExp))

#når penger- må ofte bruke log
gapminder_plus %>% ggplot()+
  geom_line(mapping=aes(x=log(gdpPercap), y=lifeExp, color=country, group=country))

by_country %>%
            
  mutate(model=purrr::map(data, ~lm(lifeExp~log(gdpPercap), data=.x))) %>% 
  mutate(summr=map(model,broom::glance)) %>% 
  unnest(summr) %>% arrange(r.squared) %>% filter(r.squared<0.1) %>% 
  select(country) %>% left_join(gapminder_plus) %>% 
  ggplot()+
  geom_point(mapping=aes(x=log(gdpPercap), y=lifeExp, color=country, group=country))

#lagring
saveRDS(by_country, "by_country_tibble.rds")

#hente frem igjen
my_fresh_by_country<-readRDS("by_country_tibble.rds")

write_csv(gapminder_plus,"gapminder_plus_AMS")
  
  
  