import joblib
import optuna
import pandas as pd
import lightgbm as lgb
import xgboost as xgb
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.linear_model import LogisticRegression
from sklearn.neural_network import MLPClassifier
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score
from imblearn.over_sampling import SMOTE

# Load preprocessed dataset
df = pd.read_csv("processed_data.csv")

# Encode categorical variables
from sklearn.preprocessing import LabelEncoder, StandardScaler

le_plant = LabelEncoder()
df["Plant Type"] = le_plant.fit_transform(df["Plant Type"])

le_moisture = LabelEncoder()
df["Moisture 1"] = le_moisture.fit_transform(df["Moisture 1"])
df["Moisture 2"] = le_moisture.transform(df["Moisture 2"])
# df["Moisture 3"] = le_moisture.transform(df["Moisture 3"])


# Normalize numerical features
scaler = StandardScaler()
df[["Humidity", "Temperature"]] = scaler.fit_transform(df[["Humidity", "Temperature"]])

# Separate features and target variable
X = df.drop(columns=["Motor State"])
y = df["Motor State"]

# Apply SMOTE for class balancing
smote = SMOTE(random_state=42)
X_resampled, y_resampled = smote.fit_resample(X, y)

# Split dataset
X_train, X_test, y_train, y_test = train_test_split(X_resampled, y_resampled, test_size=0.2, random_state=42)

# Define multiple models for evaluation
models = {
    "Random Forest": RandomForestClassifier(n_estimators=200, max_depth=10, random_state=42),
}

# Train and evaluate models
best_model = None
best_accuracy = 0
best_model_name = ""

for name, model in models.items():
    print(f"Training {name}...")
    model.fit(X_train, y_train)
    y_pred = model.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    
    print(f"✅ {name} Accuracy: {accuracy * 100:.2f}%")

    # Save the best model
    if accuracy > best_accuracy:
        best_model = model
        best_accuracy = accuracy
        best_model_name = name

# Save the best-performing model
joblib.dump(best_model, "smart_irrigation_best_model.pkl")

print(f"\n🎉 Best Model: {best_model_name} with Accuracy: {best_accuracy * 100:.2f}%")
print("✅ Model saved as smart_irrigation_best_model.pkl")




# import pandas as pd
# from sklearn.model_selection import train_test_split
# from sklearn.preprocessing import LabelEncoder
# from sklearn.metrics import accuracy_score
# from sklearn.linear_model import LogisticRegression
# from sklearn.svm import SVC
# from sklearn.tree import DecisionTreeClassifier
# from sklearn.ensemble import RandomForestClassifier, GradientBoostingClassifier

# # Load dataset
# df = pd.read_csv("processed_data.csv")

# # Encode categorical columns
# for col in ['Plant Type', 'Moisture 1', 'Moisture 2']:
#     le = LabelEncoder()
#     df[col] = le.fit_transform(df[col])

# # Split dataset
# X = df.drop('Motor State', axis=1)
# y = df['Motor State']
# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# # Define models
# models = {
#     "Logistic Regression": LogisticRegression(max_iter=1000),
#     "Support Vector Machine": SVC(),
#     "Decision Tree": DecisionTreeClassifier(),
#     "Random Forest": RandomForestClassifier(n_estimators=100),
#     "Gradient Boosting": GradientBoostingClassifier()
# }

# # Train and print accuracy in percentage
# print("Model Accuracies (%):\n----------------------")
# for name, model in models.items():
#     model.fit(X_train, y_train)
#     predictions = model.predict(X_test)
#     accuracy = accuracy_score(y_test, predictions) * 100
#     print(f"{name}: {accuracy:.2f}%")
