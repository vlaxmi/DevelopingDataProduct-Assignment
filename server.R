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