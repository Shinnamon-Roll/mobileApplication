import pymysql
from werkzeug.wrappers import Request, Response
from flask import flash, render_template, request
from flask import jsonify
from flask import Flask
from flaskext.mysql import MySQL

app = Flask(__name__)
mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'what'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

@app.route("/")
def hello():
    return """
    Flask API !<br>
    <a href='/new_user'>add</a>insert new<br>
    <a href='/emp'>emp</a>Show all<br>
    <b>/create</b> Insert new Record<br>
    <b>/emp/<id></b> get by ID<br>
    <b>/update/<id></b> Edit info<br>
    <b>/delete/<id></b> Delete by  ID<br>
    """
@app.route('/new_user')
def add_user_view():
    return render_template('add.html')

@app.route('/create', methods=['POST'])
def create_emp():
    conn = None
    cursor = None
    try:        
        _json = request.json
        print(_json)
        _name = _json['name']
        _email = _json['email']
        _phone = _json['phone']
        _address = _json['address']
        _birthdate = _json.get('birthdate')
        _weight = _json.get('weight')
        _height = _json.get('height')
        if _name and _email and _phone and _address and request.method == 'POST':
            conn = mysql.connect()
            cursor = conn.cursor(pymysql.cursors.DictCursor)
            sqlQuery = "INSERT INTO emp(name, email, phone, address, birthdate, weight, height) VALUES(%s, %s, %s, %s, %s, %s, %s)"
            bindData = (_name, _email, _phone, _address, _birthdate, _weight, _height)
            cursor.execute(sqlQuery, bindData)
            conn.commit()
            respone = jsonify('Employee added successfully!')
            respone.status_code = 200
            #flash('User added successfully!')
            #redirect('/')
            return respone
        else:
            return showMessage()
    except Exception as e:
        print(e)
    finally:
        if cursor:
            cursor.close() 
        if conn:
            conn.close()
        
@app.route('/emp')
def emp():
    conn = None
    cursor = None
    try:
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT id, name, email, phone, address, birthdate, weight, height FROM emp")
        empRows = cursor.fetchall()
        respone = jsonify(empRows)
        respone.status_code = 200
        return respone
    except Exception as e:
        print(e)
    finally:
        if cursor:
            cursor.close() 
        if conn:
            conn.close() 

@app.route('/emp/<int:emp_id>')
def emp_details(emp_id):
    conn = None
    cursor = None
    try:
        conn = mysql.connect()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT id, name, email, phone, address, birthdate, weight, height FROM emp WHERE id =%s", emp_id)
        empRow = cursor.fetchone()
        respone = jsonify(empRow)
        respone.status_code = 200
        return respone
    except Exception as e:
        print(e)
    finally:
        if cursor:
            cursor.close() 
        if conn:
            conn.close()

@app.route('/update/<int:emp_id>', methods=['PUT'])
def update_emp(emp_id):
    conn = None
    cursor = None
    try:
        _json = request.json
        #_id = _json['id']
        _name = _json['name']
        _email = _json['email']
        _phone = _json['phone']
        _address = _json['address']
        _birthdate = _json.get('birthdate')
        _weight = _json.get('weight')
        _height = _json.get('height')
        if _name and _email and _phone and _address and emp_id and request.method == 'PUT':
            sqlQuery = "UPDATE emp SET name=%s, email=%s, phone=%s, address=%s, birthdate=%s, weight=%s, height=%s WHERE id=%s"
            bindData = (_name, _email, _phone, _address, _birthdate, _weight, _height, emp_id,)
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.execute(sqlQuery, bindData)
            conn.commit()
            respone = jsonify('Employee updated successfully!')
            respone.status_code = 200
            return respone
        else:
            return showMessage()
    except Exception as e:
        print(e)
    finally:
        if cursor:
            cursor.close() 
        if conn:
            conn.close()

@app.route('/delete/<int:emp_id>', methods=['DELETE'])
def delete_emp(emp_id):
    conn = None
    cursor = None
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM emp WHERE id =%s", (emp_id,))
        conn.commit()
        respone = jsonify('Employee deleted successfully!')
        respone.status_code = 200
        return respone
    except Exception as e:
        print(e)
    finally:
        if cursor:
            cursor.close() 
        if conn:
            conn.close()      

if __name__ == '__main__':
    from werkzeug.serving import run_simple
    app.debug = True
    run_simple('10.110.4.44', 5000, app) # change port number
    
