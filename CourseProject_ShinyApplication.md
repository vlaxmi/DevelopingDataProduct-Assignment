---
title: "CourseProject"
author: "Vijay Laxmi"
date: "Saturday, November 15, 2014"
output: pdf_document
---

This is a sample shiny application that shows calculation of simple Energy Consumption

The simple energy consumption calculator is based on power used by specific appliance and number of hours per day. The energy E in kilowatt-hours (kWh) per day is equal to the power P in watts (W) times number of usage hours per day t divided by 1000 watts per kilowatt :

E(kWh/day) = P(W) × t(h/day) / 1000(W/kW)

###How to use this calculator:
1. User selects an appliance from a list of appliances for which energy cost needs to be calculated. e.g. Clothes dryer 
2. Once user selects an appliance, power consumption by that appliance appears in the text box e.g. 3000 watts will appear
3. User can change that power consumption if desire so. e.g. change to 3010
4. By default, number of hour is 1 and user can change the number of hours e.g. 10
5. Whether there is a change in appliance or power consumption or number of hours, all following output will be generated
- Energy Consumption by day - 30.1 (e.g. based on power=3010 and hours =10)
- Energy Consumption by month - 903 (e.g. based on power=3010 and hours =10, day=30)
- Energy Consumption by year - 10836 (e.g. based on power=3010 and hours =10, day=365)

###Methodology
This calculator is a shiny application and code is present in files ui.R and server.R. In ui.R, we use selectInput widget to select an appliance and numericInput to enter number of hours. However textInput label power is filled by Server side that observes the value of appliance and stores appliance value in a textInput box.

If there is any change in value of appliance, power value or number of hours, server side script re-runs all functions in server side that are part of function(input, output). This renders mainPanel code in ui.R

Here is a code for ui.R


```r
ibrary(shiny)

shinyUI(
    pageWithSidebar(
        #Application title
        headerPanel("Energy Consumption Calculator"),
        
        sidebarPanel(
            ##Selectbox for selecting an appliance
            selectInput("appliance", label = h3("Select appliance"), 
                        choices = list("--select--" = 1, 
                                       "Clothes dryer" = 3000, 
                                       "Clothes iron" = 2400,
                                       "Dishwasher" = 1600), 
                        selected = 1),
            
           ##server side observes appliance selectbox and put the value in power text input
           ##user can change the value of power text
           uiOutput('power'),

           ##numeric input to enter hours per day
           numericInput('hours', 'Hours of use per day', 1, min=1, max=24, step=1)
        ),
        
        ##right side panel showcasing output
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
           )
        )
    )
```

Here is a code of server.R


```r
library(shiny)

energyConsumption <- function(power,hours,day) (power*hours*day)/1000

shinyServer(
    function(input,output){
        output$power <- renderUI({ 
            textInput("power", "Power Consumption", input$appliance)
        })
        output$appliance <- renderPrint({input$appliance})
        output$energy_day <- renderPrint({
            energyConsumption(as.numeric(input$power), input$hours,1)})
        output$energy_month <- renderPrint({
            energyConsumption(as.numeric(input$power), input$hours,30)})
        output$energy_year <- renderPrint({
            energyConsumption(as.numeric(input$power), input$hours,360)})
    }
)
```
