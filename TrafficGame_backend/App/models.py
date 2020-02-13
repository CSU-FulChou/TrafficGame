# 作者：vincent
# code time：2020-02-13 19:27
from App.ext import db


class User(db.Model):
    id = db.Column(db.String(50),primary_key=True)
    username = db.Column(db.String(80))
    password = db.Column(db.String(80),default='password')

    def save(self):
        db.session.add(self)
        db.session.commit()




