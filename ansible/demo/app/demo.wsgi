import os
os.environ['DATABASE_URI'] = 'mysql+pymysql://demo:demo@18.175.166.214/demo'

import sys
sys.path.insert(0, '/var/www/demo')

from demo import app as application
