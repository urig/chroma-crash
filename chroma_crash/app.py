import logging
from flask import Flask

app = Flask(__name__)


@app.route("/")
def hello_world():
    logging.basicConfig()
    try:
        import chromadb
    except Exception as ex:
        logging.exception("importing chromadb failed")
        return str(ex)
    logging.info("importing chromadb succeeded")
    return "<p>Hello, World!</p>"
