from flask import Flask
from flask import render_template
import socket
import mysql.connector
import os
import json
import subprocess
import boto3

app = Flask(__name__)

DB_Host = os.environ.get('DB_Host') or "mysql"
DB_Database = os.environ.get('DB_Database') or "mysql"
DB_User = os.environ.get('DB_User')
DB_Password = os.environ.get('DB_Password')
group_no = os.environ.get('GROUP_NO')
container_dir_path = "/clo835/config/image_url" # dir path of container

if os.path.exists(container_dir_path): #if dir exists
    img_file = open(container_dir_path) #open obj dir
    json_url = json.load(img_file) #generate json
    #retrive s3 images locally using aws cli command
    for img_url in json_url:
        comd = "aws s3 cp " + json_url[img_url] + f" static/img/{img_url}.jpg"
        print("Command :", comd)
        callprocess = subprocess.Popen(comd, shell=True, stdout = subprocess.PIPE)
else: 
    json_url = {}

print(" S3 img urls: ", json_url)

@app.route("/")
def main():
    db_connect_result = False
    err_message = ""
    try:
        mysql.connector.connect(host=DB_Host, database=DB_Database, user=DB_User, password=DB_Password)
        color = '#39b54b'
        db_connect_result = True
        image_url = json_url["success_url"] if json_url else "unvailable"
    except Exception as e:
        color = '#ff3f3f'
        err_message = str(e)
        image_url = json_url["failed_url"] if json_url else "unvailable"
    
    return render_template('hello.html', debug="Environment Variables: DB_Host=" + (os.environ.get('DB_Host') or "Not Set") + "; DB_Database=" + (os.environ.get('DB_Database')  or "Not Set") + "; DB_User=" + (os.environ.get('DB_User')  or "Not Set") + "; DB_Password=" + (os.environ.get('DB_Password')  or "Not Set") + "; " + err_message, db_connect_result=db_connect_result, name=socket.gethostname(), color=color, group_no=group_no, image_url=image_url)

@app.route("/debug")
def debug():
    color = '#2196f3'
    return render_template('hello.html', debug="Environment Variables: DB_Host=" + (os.environ.get('DB_Host') or "Not Set") + "; DB_Database=" + (os.environ.get('DB_Database')  or "Not Set") + "; DB_User=" + (os.environ.get('DB_User')  or "Not Set") + "; DB_Password=" + (os.environ.get('DB_Password')  or "Not Set"), color=color)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=81)
