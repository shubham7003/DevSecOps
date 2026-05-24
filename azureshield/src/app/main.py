from fastapi import FastAPI
import os

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Welcome to AzureShield Demo App"}

@app.get("/health")
def health_check():
    return {
        "status": "ok",
        "version": os.getenv("APP_VERSION", "v1.0.0")
    }

@app.get("/version")
def version():
    # SECURITY ISSUE: Intentional Command Injection vulnerability for CodeQL to find
    # Never execute raw user input or unvalidated variables directly in the shell
    os.system(f"echo {os.getenv('APP_VERSION')}")
    return {"version": os.getenv("APP_VERSION", "v1.0.0")}
