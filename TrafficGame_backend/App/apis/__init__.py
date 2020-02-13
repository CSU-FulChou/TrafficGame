# 作者：vincent
# code time：2020-02-13 16:23


from flask import Blueprint
from flask_marshmallow import Marshmallow

ma = Marshmallow()
api = Blueprint('api',__name__)

def init_apis(app):
    ma.init_app(app)
    app.register_blueprint(api)


@api.route('/hello')
def hello():
    return "hello world"

@api.route('/')
def index():
    return "index"