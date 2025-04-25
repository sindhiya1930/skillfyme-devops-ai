from flask import Flask, request, redirect, url_for
import os

app = Flask(__name__)

# Set the upload folder and allowed extensions
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['ALLOWED_EXTENSIONS'] = {'png', 'jpg', 'jpeg', 'gif'}

# Ensure the upload folder exists
if not os.path.exists(app.config['UPLOAD_FOLDER']):
os.makedirs(app.config['UPLOAD_FOLDER'])

# Function to check if the file extension is allowed
def allowed_file(filename):
return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

@app.route('/')
def index():
return '''
<!doctype html>
<title>Upload an Image</title>
<h1>Upload an Image</h1>
<form method="POST" enctype="multipart/form-data">
<input type="file" name="file">
<input type="submit" value="Upload">
</form>
'''

@app.route('/', methods=['POST'])
def upload_file():
if 'file' not in request.files:
return redirect(request.url)
file = request.files['file']
if file and allowed_file(file.filename):
filename = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
file.save(filename)
return f'File uploaded successfully: {filename}'
return 'Invalid file format'

if __name__ == '__main__':
app.run(debug=True, host='0.0.0.0')
