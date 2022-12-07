library(shiny)
library(plotly)
scatter_sidebar_content <- sidebarPanel(
  selectInput(
    "scattervar",
    label = "Choose your variable to view",
    choices = list(
      "Total CO2 emmisions" = "co2",
      "CO2 emmisions from coal" = "coal_co2",
      "CO2 emmisions from cement" = "cement_co2",
      "CO2 emmisions from flaring" = "flaring_co2",
      "CO2 emmisions from gas" = "gas_co2",
      "CO2 emmisions from oil" = "oil_co2"
    )
  ),
  
  sliderInput("yearvar", label = "choose range of year", 1750, 2022, value = c(1750, 2022), sep = "")
)

scatter_main_content <- mainPanel(
  plotlyOutput("scatter"),
  h4("Plot Summary:"),
  p("This chart is inlcuded in this project since through the chart we can observe
    the amount of CO2 emmisions for every cause of CO2 emmisions throughout the years
    for the US. I mainly focused on the US since that is the place where we currently
    are in."),
  h4("Patterns:"),
  p("Total CO2 emmisions: We can see how the total of all CO2 emmisions progressivily 
    increased throughout time and with small drops but continously increases after."),
  p("CO2 emmisions from coal: We can see how CO2 emmisions from coal has increased througout
    time but starting from around 2008, emmisions from coal begin to drop consistantly. "),
  p("CO2 emmisions from cement: We can see how CO2 emmisions from cement has speradictly
    gone up and down from the year of 1920 and onward but has maintained to increase over time"),
  p("CO2 emmisions from flaring: We can see how CO2 emmisions from flaring dips and then
    increases througout time starting around 1950."),
  p("CO2 emmisions from gas: We can see how CO2 emmisions from gas has increased since 1882,
    dropped a bit and continously began to increase afterwards to this day."),
  p("CO2 emmisions from oil: We can see how CO2 emmisions from oil has increased
    from throughout time until 1978 where it fluctuates up and down evenly afterwards but later on dips
    in 2020.")
  
)

scatter_panel <- tabPanel(
  "Scatter",
  titlePanel("Types of CO2 emmisions through the years"),
  sidebarLayout(
    scatter_sidebar_content,
    scatter_main_content
  )
)

introduction_content <- mainPanel(
  p("Throughout time one of the reoccurring concearns we have been facing and 
    will cause major issues in the future is the pollution caused by carbon 
    carbon emmisions."),
  p("For example, ", textOutput("max", container = span), " tonnes of CO2 emmisions were reported in the 
    entire ", textOutput("maxcountry", container = span), " for the year of ", textOutput("maxyear", 
                                                                                          container = span), ". The highest amount of CO2 emmisions throughout the world to be near our current
    year is deemed to be very concearning. Focusing on where we currently are, which is in the US, 
    the average percent growth of total CO2 emmisions throughout the years in the US is ", textOutput("avgpercus", 
                                                                                                      container = span), "%, which is pretty concearning due to the fact that the average is a positive number,
    meaning that it is always increasing."),
  p("Also the average growth of emmisions in the US througout time is ", 
    textOutput("avggrowth", container = span), " tonnes which is also really concearning due to the fact that 
    it is a pretty large number in tonnes and that it represents how much on average per year the CO2 emmisions 
    increase in the US.")
)

introduction_panel <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  introduction_content
  
)

ui <- navbarPage(
  "CO2 emmisions through the years",
  introduction_panel,
  scatter_panel
)
