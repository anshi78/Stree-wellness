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