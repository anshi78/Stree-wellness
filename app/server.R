library(shiny)
library(randomForest)

# Load model & scaling params
model <- readRDS("../models/stress_model.rds")
scaling_params <- readRDS("../models/scaling_params.rds")
means <- scaling_params$means
sds   <- scaling_params$sds

# Function to get recommendation based on predicted stress
get_recommendation <- function(stress_level) {
  level <- as.numeric(as.character(stress_level))
  if (level <= 3) {
    return("You're doing great! Maintain a balanced routine with good sleep, exercise, and hydration. 😊")
  } else if (level <= 6) {
    return("Consider light meditation, staying active daily, and reducing caffeine. Talk to friends or take short breaks during work. 😌")
  } else if (level <= 8) {
    return("Your stress seems high. Try deep breathing, reduce screen time, and limit stimulants like caffeine/alcohol. Seek social support. 🧘")
  } else {
    return("Critical stress detected. Please consult a therapist or counselor. Practice mindfulness daily. Prioritize sleep and avoid toxic environments. ❤️")
  }
}

# Server logic
shinyServer(function(input, output) {
  observeEvent(input$predict, {
    tryCatch({
      # New input data
      new_data <- data.frame(
        Age = as.numeric(input$age),
        Sleep.Hours = as.numeric(input$sleep),
        Caffeine.Intake..mg.day. = as.numeric(input$caffeine),
        Physical.Activity..hrs.week. = as.numeric(input$activity),
        Heart.Rate..bpm. = as.numeric(input$heartrate),
        Breathing.Rate..breaths.min. = as.numeric(input$breathing)
      )

      # Scale input
      new_data_scaled <- as.data.frame(scale(new_data, center = means, scale = sds))
      pred <- predict(model, new_data_scaled)

      # Show prediction + recommendation
      output$result <- renderText({
        paste0("Predicted Stress Level: ", as.character(pred), "\n\n",
               "Recommendation:\n", get_recommendation(pred))
      })
    }, error = function(e) {
      output$result <- renderText({ paste("Error:", e$message) })
    })
  })
})
