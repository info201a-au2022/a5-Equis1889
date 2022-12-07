library("dplyr")
library("ggplot2")
library("plotly")
library("tidyverse")
df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
codebook <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-codebook.csv")

us_data <- df %>%
  filter(country == "United States")

CO2_avg_growth <- us_data %>%
  summarise(avg_growth = mean(co2_growth_abs, na.rm = TRUE)) %>%
  pull(avg_growth)

server <- function(input, output) {
  output$scatter <- renderPlotly({
    return(ggplot(data = us_data, mapping = aes_string(y = input$scattervar)) +
             geom_point(mapping = aes(x = year, color = country)) +
             xlim(input$yearvar[1], input$yearvar[2]) +
             ylab("CO2 emmisions by the million ton") +
             ggtitle("CO2 emmision types over time")
    )
  })
  
  output$max <- renderText({
    return(max_CO2_emmisions <- df %>%
             group_by(year) %>%
             summarise(max_co2 = max(co2, na.rm = TRUE)) %>%
             filter(max_co2 == max(max_co2)) %>%
             pull(max_co2))
  })
  
  output$maxcountry <- renderText({
    return(country_of_max_CO2_emmisions <- df %>%
             group_by(country) %>%
             summarise(max_co2 = max(co2, na.rm = TRUE)) %>%
             filter(max_co2 == max(max_co2)) %>%
             pull(country))
  })
  
  output$maxyear <- renderText({
    return(year_of_max_CO2_emmisions <- df %>%
             group_by(year) %>%
             summarise(max_co2 = max(co2, na.rm = TRUE)) %>%
             filter(max_co2 == max(max_co2)) %>%
             pull(year))
  })
  
  output$avgpercus <- renderText({
    return(CO2_avg_growth_perc <- us_data %>%
             summarise(avg_co2_avg_perc = mean(co2_growth_prct, na.rm = TRUE)) %>%
             pull(avg_co2_avg_perc))
  })
  
  output$avggrowth <- renderText({
    return(CO2_avg_growth_final <- CO2_avg_growth * 1000000)
  })
}