# 作者：vincent
# code time：2020-02-13 16:19

import os

BASR_DIR = os.path.dirname(os.path.abspath(__file__))
# 本文件的用途就是分装一下连接数据库配置。目前
def get_db_uri(dbinfo):
    engine = dbinfo.get("ENGINE") or 'sqlite'
    driver = dbinfo.get("DRIVER") or 'sqlite'
    user = dbinfo.get("USER") or ''
    passsword = dbinfo.get("PASSWORD") or ''
    host = dbinfo.get("HOST") or ''
    port = dbinfo.get("PORT") or ''
    name = dbinfo.get("NAME") or ''
    return '{}+{}://{}:{}@{}:{}/{}'.format(engine,driver,user,passsword,host,port,name)


# 写一些共有的属性：
class BaseConfig():

    DEBUG = False
    TESTING = False
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    SECRET_KEY = 'rick'
    # 使用flask-session将session通过键值对的形式存储在redis中
   # SESSION_TYPE = 'redis'



class DevelopConfig(BaseConfig):

    DEBUG = True

    dbinfo = {
        'ENGINE' : 'mysql',
        'DRIVER' : 'pymysql',
        'USER': 'hhh',
        'PASSWORD': 'Sqlroot123!',
        'HOST': '47.102.111.5',
        'PORT': '3306',
        'NAME': 'trafficGame',

    }
    SQLALCHEMY_DATABASE_URI = get_db_uri(dbinfo)

    #print(SQLALCHEMY_DATABASE_URI)

# 测试环境
class TestConfig(BaseConfig):
    pass


# 生产环境：
class ProductionConfig(BaseConfig):
    pass


envs = {
    'develop':DevelopConfig,
    'testing':TestConfig,
    'product':ProductionConfig,
    'defult':DevelopConfig
}

