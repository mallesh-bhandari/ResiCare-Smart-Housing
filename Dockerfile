# 1. Official Python image use karo
FROM python:3.10-slim

# 2. Container ke andar ek folder banao
WORKDIR /app

# 3. requirements.txt ko container mein copy karo aur install karo
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Apne project ka saara code container mein copy karo
COPY . .

# 5. Flask app run karne ke liye port expose karo
EXPOSE 5000

# 6. Command jo project ko start karegi
CMD ["python", "main.py"]