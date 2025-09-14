from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
import os
import socket

app = Flask(__name__)

# Use the env var if present; default to PyMySQL DSN for compatibility
app.config["SQLALCHEMY_DATABASE_URI"] = os.environ.get(
    "DATABASE_URI",
    "mysql+pymysql://demo:demo@192.168.1.1/demo",
)
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)
hostname = socket.gethostname()

@app.route("/")
def index():
    return f"Hello, from sunny {hostname}!\n"

@app.route("/db")
def dbtest():
    try:
        # Simple connectivity check; no schema creation required
        with db.engine.connect() as conn:
            conn.execute(text("SELECT 1"))
        return f"Database Connected from {hostname}!\n"
    except Exception as e:
        # e.message doesn't exist in Py3; use str(e)
        return str(e) + "\n", 500

if __name__ == "__main__":
    # For local testing only; mod_wsgi will import `app` directly
    app.run(host="127.0.0.1", port=8000, debug=True)
