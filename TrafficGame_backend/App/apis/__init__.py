# 作者：vincent
# code time：2020-02-13 16:23


from flask import Blueprint, request, abort

from flask_marshmallow import Marshmallow

from App.ext import db
from App.models import User
from testMatlab import my_sum

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

@api.route('/createdb')
def creat_db():
    db.create_all()
    return "success"

@api.route('/dropdb')
def drop_db():
    db.drop_all()
    return "success"

@api.route('/testMatlab')
def testMatlab():
    result = my_sum(4,5)
    print(result)
    return "success"


@api.route('/adduser',methods=['POST','GET'])
def adduser():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        user = User()
        user.username = username
        user.password = password
        if not user.save():
            abort(404)

    data = {
        "status": 200,
        "msg": "ok",
    }
    return data

@api.route('/login',methods=['POST'])
def login():
    msg = ''
    status = 404
    username = request.form.get('username')
    password = request.form.get('password')
    user = User.query.filter(User.username == username)

    print(type(user))
    print(user)
    if user is None:
        print('user no found')

    # if user.password == password:
    #     msg = 'sucess'
    #     status = 200
    #
    # else:
    #     msg = 'fail'
    #     status = 404

    data = {
        "status": status,
        "msg": msg,
    }
    return  data
