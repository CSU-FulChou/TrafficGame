# 作者：vincent
# code time：2020-02-13 16:25

# from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# migrate = Migrate()
# debugToolbar = DebugToolbarExtension()

#ma = Marshmallow()

def init_ext(app):
    db.init_app(app=app)
# 初始化管理者，需要app
#     migrate.init_app(app,db)
    #Session(app)
    # Bootstrap(app)
    # debugToolbar.init_app(app)
    #ma.init_app(app)