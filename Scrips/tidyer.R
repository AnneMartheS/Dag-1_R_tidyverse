#siste delen av dagen omhandlende tidyR. Startet med fil fra dokument de har laget til kurset. 

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator gapminder infant_mortality.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator undata total_fertility.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator gapminder infant_mortality.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator undata total_fertility.xlsx")

#TIDYR FILES:
download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=xlsx", 
              destfile = "Data/indicator gapminder infant_mortality.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator undata total_fertility.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=xlsx", 
              destfile = "Data/indicator gapminder infant_mortality.xlsx")

download.file(url = "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx", 
              destfile = "Data/indicator undata total_fertility.xlsx")


#Åpne en excelfil i R: 
  
library(readxl)

raw_fert<-read_excel(path="Data/indicator undata total_fertility.xlsx", sheet ="Data")  
raw_infantMort<-read_excel(path = "Data/indicator gapminder infant_mortality.xlsx")


#hvordan se rådataen: 
raw_infantMort
raw_fert

fert_Norway <-infantMort %>% 
  filter (country=="Norway") %>%
  select(year)


#hvordan tidyr g få inn data (data som ikke er fra samme kilde). Data bestr av celler, colloner, rader. Data som går inn
#består av verdier (observasjoner- units vi måler, variabler- alle verdier i ulike enheter/units). Tidyr format: variabler: kolloner, 

gapminder

raw_fert
#alle verdiene man ser er mål av fert rate. For hvert år som målinger er tatt er det lagret kolloner. For hver måling kan man 
#kan .. forstår ikke helt dette. Men R har en funksjon som kan hjelpe til med å endre dataen til å passe R. 
#Gather: må gi denne fnksjonen 3 informasjoner først: Fortell hva det er man ønsker å samle informasjon om, ID,1-vil lage en 
#ny datasett som heter fert. 2. skriv hva man vil at det skal hete (rename). 3.Hvilken verdi skal inn, hva skal den hete, 
#hvilken kollone vil man samle (Gather). I dette tilfelle alt utenom country. 

fert<- raw_fert %>%
  rename(country=`Total fertility rate`) %>%
  gather(key=year,value=fert,-country) %>%
  mutate(year=as.integer(year))
fert

fert %>% 
  filter (country=="Norway") %>%
  (x=year, y=fert)
  
  


