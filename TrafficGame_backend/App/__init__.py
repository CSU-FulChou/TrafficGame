# 作者：vincent
# code time：2020-02-13 16:18

from flask import Flask


from App.apis import init_apis
from App.ext import init_ext
from App.setting import envs
#from App.views.first_blue import blue

def create_app(env):
    app = Flask(__name__)

    init_ext(app)
    # init_views(app)
    init_apis(app)
    # init_api_ma(app)
    app.config.from_object(envs.get(env))


    # app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///sqlite.db'
    # app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    # app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://hhh:Sqlroot123!@47.102.111.5:3306/trafficGame'
    #app.register_blueprint(user)
    #app.register_blueprint(blue)
    #init_route(app)

    return app