from flask import Flask, jsonify

app = Flask(__name__)

# @app.route('/home')
@app.route('/home', methods=['GET'])
def home():
    return jsonify(message="Welcome to DevOps Session from App One!!")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)