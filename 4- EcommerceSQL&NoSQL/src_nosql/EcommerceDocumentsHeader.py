import pymongo
import json
import pprint
from datetime import datetime

conn = pymongo.MongoClient("mongodb+srv://" + mongo_user + ":" + mongo_pw + "@" + mongo_host + "/?retryWrites=true&w=majority&appName=" + mongo_app)

bd = conn['ecommerce_db']
db = conn['ecommerce_db']
transportadoras = db['transportadoras']
pedidos = db['pedidos']
produtos = db['produtos']
clientes = db['clientes']