#Assigning actual path to the downloaded file
data <- read.table("spellman.txt",
                   header = TRUE, row.names = 1)

#Finding the dimensions of the data frame
dim(data)

#Isolating only the cdc15 experiment (samples 23-46)
cdc15_data <- data[, 23:46]

#Loading the library
library(shiny)
#Defining the UI
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput('xcol', 'X Variable', colnames(cdc15_data)),
      selectInput('ycol', 'Y Variable', colnames(cdc15_data)),
      selectInput('point_color', 'Point Color',
                  choices = c("Red" = "red", "Blue" = "blue", "Green" = "green",
                              "Yellow" ="yellow","Pink"="pink","Orange"="orange",
                              "Purple"="purple","Black" = "black"))
    ),
    mainPanel(
      plotOutput('scatterplot')
    )
  )
)
#Defining Server
server <- function(input, output) {
  selectedData <- reactive({
    cdc15_data[, c(input$xcol, input$ycol, input$colorcol)]
  })
  output$scatterplot <- renderPlot({
    data <- selectedData()
    if (!is.null(data)) {
      plot(data[, 1], data[, 2],
           xlab = input$xcol,
           ylab = input$ycol,
           col = input$point_color,
           pch = 19,
           main = paste("Scatter Plot:", input$xcol, "vs", input$ycol))
    }
  })
}
#Running the Shiny app
shinyApp(ui = ui, server = server)


