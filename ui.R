library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Check it out, with Dr. Steven Brule"),

    # Sidebar
    sidebarLayout(
        sidebarPanel(
            h3('"My Name is Dr. Steven Brule, and I\'m here with..."'),
            textInput(inputId = "first_name", label = "Enter your first name", "Rob"),
            textInput(inputId = "last_name", label = "Enter your last name", "Aumer"),
            selectInput(inputId = "sex", label = '"Are You Mrale or Freemrale"',choices = c("Mrale", "Fremrale")),
            actionButton(inputId = "check_it_out", "Check it out")
        ),

        # Main Panel
        mainPanel(
            imageOutput("face"),
            h2(textOutput("brule_name"), size = "50px")
        )
    )
))
