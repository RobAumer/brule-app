library(shiny)

shinyServer(function(input, output) {
    
    brule_name <- eventReactive(input$check_it_out, {
        name <- brule_generator(input$first_name, input$last_name, sex()) %>%
            py_to_r()
        name
    })
    
    sex <- reactive({
        ifelse(test = input$sex == "Mrale", yes = "male", no = "female")
    })
    output$brule_name <- renderText({
        paste("... ", brule_name())
    })
    
    image_data <- reactive({
        input$check_it_out # Force it to update each time
        image_src <- paste0("images/", sample(dir("images/"), size = 1))
        
        list(src = image_src, 
             contentType = "image/jpeg",
             alt = " ")
    })
    
    output$face <- renderImage(deleteFile = FALSE, {
        image_data()
    })
    
})
