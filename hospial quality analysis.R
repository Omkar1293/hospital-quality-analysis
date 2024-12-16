# Load necessary libraries
library(tidyverse)
library(ggplot2)
library(dplyr)

# Step 1: Simulate or Load Data
# Replace this with actual hospital quality data
set.seed(123)
hospital_data <- data.frame(
  HospitalID = as.factor(1:50),
  PatientSatisfaction = round(runif(50, 50, 100), 1),  # Satisfaction score (0-100)
  ReadmissionRate = round(runif(50, 5, 20), 1),  # Percentage
  MortalityRate = round(runif(50, 1, 10), 1),  # Percentage
  AverageTreatmentCost = round(runif(50, 5000, 20000), 2)  # In USD
)

# View the dataset
head(hospital_data)

# Step 2: Summary Statistics
summary_stats <- hospital_data %>%
  summarise(
    AvgSatisfaction = mean(PatientSatisfaction),
    AvgReadmissionRate = mean(ReadmissionRate),
    AvgMortalityRate = mean(MortalityRate),
    AvgTreatmentCost = mean(AverageTreatmentCost)
  )
print(summary_stats)

# Step 3: Visualize Key Metrics

# Patient Satisfaction Distribution
ggplot(hospital_data, aes(x = PatientSatisfaction)) +
  geom_histogram(bins = 10, fill = "blue", alpha = 0.7) +
  labs(
    title = "Distribution of Patient Satisfaction Scores",
    x = "Patient Satisfaction Score",
    y = "Frequency"
  ) +
  theme_minimal()

# Readmission Rate vs. Mortality Rate
ggplot(hospital_data, aes(x = ReadmissionRate, y = MortalityRate)) +
  geom_point(color = "red", size = 2) +
  labs(
    title = "Relationship Between Readmission and Mortality Rates",
    x = "Readmission Rate (%)",
    y = "Mortality Rate (%)"
  ) +
  theme_minimal()

# Average Treatment Cost vs. Patient Satisfaction
ggplot(hospital_data, aes(x = AverageTreatmentCost, y = PatientSatisfaction)) +
  geom_point(color = "green", size = 2) +
  geom_smooth(method = "lm", color = "black", linetype = "dashed") +
  labs(
    title = "Treatment Cost vs. Patient Satisfaction",
    x = "Average Treatment Cost (USD)",
    y = "Patient Satisfaction Score"
  ) +
  theme_minimal()

# Step 4: Identify Top Hospitals
top_hospitals <- hospital_data %>%
  filter(
    PatientSatisfaction > 85 & ReadmissionRate < 10 & MortalityRate < 5
  ) %>%
  arrange(desc(PatientSatisfaction))
print(top_hospitals)

# Step 5: Save Processed Data
write.csv(hospital_data, "hospital_quality_data.csv", row.names = FALSE)
