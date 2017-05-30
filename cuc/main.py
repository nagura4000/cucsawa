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
import urllib.request
import json
# install(PgSQLPlugin('dbname=sawachi, user=cuc password='))

# @route('/hello')
# def hello(db):
#     c = db.execute('''SELECT * FROM client_mst''')
#     result = c.fetchone()
#     return template('hello', rows=result)

# @route('/test')
# def test():
#   import mysql.connector
#   connect = mysql.connector.connect(db='sawachi', host='localhost', port=3306, user='root', passwd='')
#
#   cur=connect.cursor()
#   cur.execute("SELECT * FROM client_mst")
#   result = cur.fetchall()
#   name = result[0][1]
#   return template('hello', name=name)



connect = mysql.connector.connect(db='sawachi', host='localhost', port=3306, user='root', passwd='root')

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
@route('/css/<filename>')
def css_dir(filename):
    """ set css dir """
    return static_file(filename, root=BASE_DIR+"/views/css")

@route('/js/<filename>')
def js_dir(filename):
    """ set js dir """
    return static_file(filename, root=BASE_DIR+"/views/js")

@route('/img/<filename>')
def img_dir(filename):
    """ set img file """
    return static_file(filename, root=BASE_DIR+"/views/img")

@route('/font/<filename>')
def font_dir(filename):
    """ set font file """
    return static_file(filename, root=BASE_DIR+"/views/fonts")


@route('/employee')
def employee():
  cur=connect.cursor()
  cur.execute("SELECT * FROM employee_mst")
  result = cur.fetchall()
  return template('employee', rows=result)

@route('/planning')
def planning():
  cur=connect.cursor()
  cur.execute("SELECT * FROM employee_mst")
  employee = cur.fetchall()
  return template('production_planning', rows=employee)

@route('/production')
def production():
  cur=connect.cursor()
  sql = """     SELECT
                    pp.id,
                    em.name,
                    mm.name,
                    im.name,
                    pp.production_number,
                    pp.production_date ,
                    ifnull(pi.success_number, 0)
                FROM production_planning as pp
                join employee_mst em on (pp.id_employee_mst = em.id)
                join machine_mst mm on (pp.id_machine_mst = mm.id)
                join item_mst as im on (pp.id_item_mst = im.id)
                left join ( select
                                    pid.id_production_planning,
                                    sum(pid.production_number) as success_number
                            from production_info as pid
                            group by pid.id_production_planning
                            ) as pi on  (pp.id = pi.id_production_planning)
        """
  cur.execute(sql)
  production_planning = cur.fetchall()
  return template('production', rows=production_planning)

@route('/production_detail', method='GET')
def production_detail():
    pralningid = request.query.get('planningId')
    cur=connect.cursor()
    sql = """     SELECT
                      pp.id,
                      em.name,
                      mm.name,
                      im.name,
                      pp.production_number,
                      pp.production_date
                  FROM production_planning as pp
                  join employee_mst em on (pp.id_employee_mst = em.id)
                  join machine_mst mm on (pp.id_machine_mst = mm.id)
                  join item_mst as im on (pp.id_item_mst = im.id)
                  where pp.id = {pralningid}
        """.format(**vars());
    cur.execute(sql)
    production_planning = cur.fetchall()

    # 生産実績
    sql = """     SELECT
                      pi.id,
                      pi.production_number,
                      pi.failure_number,
                      pi.create_start_time,
                      pi.create_end_time

                      , wm.name

                  FROM production_info as pi

                  left join stock_info as si on (si.id_production_info = pi.id)
                  left join warehouse_mst wm on (wm.id = si.id_warehouse)

                  where pi.id_production_planning = {pralningid}
        """.format(**vars());
    cur.execute(sql)
    production_infos = cur.fetchall()

    return template('production_detail', production_planning=production_planning[0], production_infos=production_infos)

@route('/production_detail', method='POST')
def registere_detail():
    id_production_planning = request.forms.get('id_production_planning')
    success_number = request.forms.get('success_number')
    failure_number = request.forms.get('failure_number')
    start_date = request.forms.get('start_date')
    end_date = request.forms.get('end_date')
    cur=connect.cursor()
    sql = """     insert into
                    production_info
                    (
                        id_production_planning,
                        production_number,
                        failure_number,
                        create_start_time,
                        create_end_time
                    )
                    values (
                        {id_production_planning},
                        {success_number},
                        {failure_number},
                        '{start_date}',
                        '{end_date}'
                    )
    """.format(**vars());
    print(sql)
    cur.execute(sql)
    connect.commit()
    redirect('/production_detail?planningId=' + id_production_planning)


@route('/stock', method='GET')
def stock_view():
    id_production_info = request.query.get('infoId')
    cur=connect.cursor()
    # 生産実績
    sql = """     SELECT
                      pi.id,
                      pi.id_production_planning,
                      pi.production_number,
                      em.name,
                      im.name,
                      si.id,
                      wm.name,
                      si.row,
                      si.col,
                      si.depth,
                      si.instock_time,
                      si.outstock_time
                  FROM production_info as pi
                  JOIN production_planning as pp on (pi.id_production_planning = pp.id)
                  join employee_mst em on (pp.id_employee_mst = em.id)
                  join machine_mst mm on (pp.id_machine_mst = mm.id)
                  join item_mst as im on (pp.id_item_mst = im.id)
                  left join stock_info as si on (si.id_production_info = pi.id)
                  left join warehouse_mst wm on (wm.id = si.id_warehouse)
                  where pi.id = {id_production_info}
        """.format(**vars());

    cur.execute(sql)
    production_infos = cur.fetchall()

    cur.execute("SELECT * FROM warehouse_mst")
    warehouses = cur.fetchall()

    return template('stock', production_infos=production_infos, warehouses=warehouses)

@route('/stock', method='POST')
def registere_stock():
    id_production_info = request.forms.get('id_production_info')
    id_warehouse = request.forms.get('id_warehouse_mst')
    row = request.forms.get('row')
    col = request.forms.get('col')
    depth = request.forms.get('depth')
    instock_time = request.forms.get('instock_time')
    cur=connect.cursor()
    sql = """     insert into
                    stock_info
                    (
                        id_production_info,
                        id_warehouse,
                        row,
                        col,
                        depth,
                        instock_time
                    )
                    values (
                        {id_production_info},
                        {id_warehouse},
                        {row},
                        {col},
                        {depth},
                        '{instock_time}'
                    )
    """.format(**vars());
    print(sql)
    cur.execute(sql)
    connect.commit()
    redirect('/stock?infoId=' + id_production_info)

@route('/stock_detail', method='GET')
def stock_detail():
    row = request.query.get('row')
    col = request.query.get('col')
    depth = request.query.get('depth')
    print(row)
    return template('stock_detail', row=row, col=col, depth=depth)

@route('/video', method='GET')
def video():
    print("aaa")
    return template('video')

@route('/temperature')
def temperature():
  cur=connect.cursor()
  #cur.execute("SELECT * FROM temperature order by id desc;")
  cur.execute("SELECT * FROM temperature order by id desc limit 40;")
  #cur.execute("SELECT * FROM temperature order by id desc limit 20;")

  result = cur.fetchall()
  return template('temperature', rows=result)

@route('/put_temperature', method='GET')
def registere_temperature():

    #location = "Tokyo,jp"
    lat = "35.741940"
    lon = "139.906838"
    mode = "json"
    metric = "metric"
    apikey = "a7a0c4494d0691013138ed27002a01b4"
    url = "http://api.openweathermap.org/data/2.5/weather?lat={a}&lon={aa}&mode={b}&units={c}&APPID={d}".format(a=lat, aa=lon, b=mode, c=metric, d=apikey)
    response = urllib.request.urlopen(url)
    weather_json = json.loads(response.read().decode('utf8'))
    out_temperature = weather_json['main']['temp']

    temperature = request.query.get('temperature')
    humidity = request.query.get('humidity')
    update_time = time.strftime('%Y-%m-%d %H:%M:00')
    cur=connect.cursor()
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
    print(sql)
    cur.execute(sql)
    connect.commit()
    redirect('/temperature')



#run (host='localhost', port=8080, debug=True)
run(host='0.0.0.0', port=80)
