# 作者：vincent
# code time：2020-02-13 16:16

# from flask_migrate import MigrateCommand
from flask_script import Manager
from App import create_app

env = 'develop'

app = create_app(env)



manager = Manager(app=app)

# manager.add_command('db',MigrateCommand)

if __name__ == '__main__':
   # app.run(debug=True)
    manager.run()
