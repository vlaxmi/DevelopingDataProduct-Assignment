library(shiny)

shinyUI(navbarPage("Vijay App",
                   
    tabPanel("Energy Consumption Calculator", 
             pageWithSidebar(
                 headerPanel("Energy Consumption Calculator"),
                 sidebarPanel(
                     selectInput("appliance", label = h3("Select appliance"), 
                                 choices = list("--select--" = 1, 
                                                "Clothes dryer" = 3000, 
                                                "Clothes iron" = 2400,
                                                "Dishwasher" = 1600), selected = 1),
                     
                     uiOutput('power'),
                     numericInput('hours', 'Hours of use per day', 1, min=1, max=24, step=1)
                 ),
                 mainPanel(
                     h3('Results of Energy Consumption'),
                     h4('Energy Consumption per day'),
                     verbatimTextOutput("energy_day"),
                     h4('Energy Consumption per month'),
                     verbatimTextOutput("energy_month"),
                     h4('Energy Consumption per year'),
                     verbatimTextOutput("energy_year"),
                     h4('Based on Energy consumption calculation'),
                     p("The energy E in kilowatt-hours (kWh) per day is equal to the power P in watts (W) times number of usage hours per day t divided by 1000 watts per kilowatt:"),
                     em("E(kWh/day) = P(W) × t(h/day) / 1000(W/kW)")
                 )##end of mainPanel
             )## end of pageWithSidebar
    ),##end of tabPanel
    
    tabPanel("Documentation", 
             includeHTML("CourseProject_ShinyApplication.html"))
   )## end of navbar
  )