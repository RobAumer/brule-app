library(shiny)
library(reticulate)
library(magrittr)

# Define any Python packages needed for the app here:
PYTHON_DEPENDENCIES = c('brule')

shinyServer(function(input, output) {
    
    # ------------------ App virtualenv setup (Do not edit) ------------------- #
    
    virtualenv_dir = Sys.getenv('VIRTUALENV_NAME')
    python_path = Sys.getenv('PYTHON_PATH')
    
    # Create virtual env and install dependencies
    reticulate::virtualenv_create(envname = virtualenv_dir, python = python_path)
    reticulate::virtualenv_install(virtualenv_dir, packages = PYTHON_DEPENDENCIES, ignore_installed=TRUE)
    reticulate::use_virtualenv(virtualenv_dir, required = T)
    
    reticulate::source_python("brule_wrapper.py", convert = FALSE)
    
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
