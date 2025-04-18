library(shiny)

shinyUI(fluidPage(
  titlePanel("Stress Prediction & Wellness Assistant"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("age", "Age", value = 30),
      numericInput("sleep", "Sleep Hours", value = 7),
      numericInput("caffeine", "Caffeine Intake (mg/day)", value = 200),
      numericInput("activity", "Physical Activity (hrs/week)", value = 3),
      numericInput("heartrate", "Heart Rate (bpm)", value = 70),
      numericInput("breathing", "Breathing Rate (breaths/min)", value = 16),
      actionButton("predict", "Predict Stress")
    ),
    
    mainPanel(
      verbatimTextOutput("result")
    )
  )
))
