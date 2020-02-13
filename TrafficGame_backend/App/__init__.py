# 作者：vincent
# code time：2020-02-13 16:18

from flask import Flask


from App.apis import init_apis
from App.ext import init_ext
from App.setting import envs

def create_app(env):
    app = Flask(__name__)

    init_ext(app)
    init_apis(app)
    app.config.from_object(envs.get(env))


    return app