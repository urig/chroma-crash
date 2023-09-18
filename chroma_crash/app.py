import logging
import google.cloud.logging
from flask import Flask

logging.basicConfig()
try:
    client = google.cloud.logging.Client()
    client.setup_logging()
except:
    pass

app = Flask(__name__)

logging.info("app loaded successfully")


@app.route("/")
def hello_world():
    try:
        import chromadb
    except Exception as ex:
        logging.exception("importing chromadb failed")
        return str(ex)
    logging.info("importing chromadb succeeded")
    return "<p>Hello, World!</p>"
