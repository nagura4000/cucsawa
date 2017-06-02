# -*- coding: utf-8 -*-
'''
Created on 2016/10/07

@author: nagura
'''
# import psycopg2
from bottle import route, run, template, request
from os.path import os
from bottle import static_file
import mysql.connector
from bottle import redirect
import time
import urllib3.request
import json
from pit import Pit
from pytz import timezone
from datetime import datetime, timedelta
import logging


@route('/temperature')
def temperature():
	try:
		logging.info("start get temperature")
		con =connect()
		cur= con.cursor()
		#cur.execute("SELECT * FROM temperature order by id desc;")
		cur.execute("SELECT * FROM temperature order by id desc limit 40;")
		#cur.execute("SELECT * FROM temperature order by id desc limit 20;")

		result = cur.fetchall()
		logging.info("close db_connection")
		logging.info("start set template")
		view = template('temperature', rows=result)
		logging.info("end set template")
	finally:
		cur.close()
		con.close()
		
	return view

@route('/put_temperature', method='GET')
def registere_temperature():
	try:
		logging.info("start put temperature")
		temperature = request.query.get('temperature')
		out_temperature = request.query.get('humidity')
		#update_time = time.strftime('%Y-%m-%d %H:%M:00')
		now = datetime.now() + timedelta(hours=9)
		#jst_now = timezone('Asia/Tokyo').localize(now)
		update_time = now.strftime('%Y-%m-%d %H:%M:00')
		con = connect()
		cur = con.cursor()
		sql = """     insert into
			    temperature
			    (
				temperature,
				humidity,
				update_time
			    )
			    values (
				{temperature},
				{out_temperature},
				'{update_time}'
			    )
		""".format(**vars());
		logging.info(sql)
		cur.execute(sql)
		con.commit()
		logging.info("close db_connection")
		redirect('/temperature')
	finally:
		cur.close()
		con.close()


def connect():
	logging.info("start get_db_connection")
	idpass = Pit.get('label')
	username = idpass['username']
	passwd = idpass['password']
	con = mysql.connector.connect(db='sawachi', host='localhost', port=3306, user=username, passwd=passwd)
	logging.info("end get_db_connection")
	return con

log_fmt = '%(asctime)s- %(name)s - %(levelname)s - %(funcName)s - %(thread)d - %(message)s'
logging.basicConfig(filename='/tmp/temperature.log',level=logging.DEBUG, format=log_fmt)
#run (host='localhost', port=8080, debug=True)
run(host='0.0.0.0', port=80)
