import os

try : 
    if os.path.exists('test.txt') :
        print('File exists')
    else :
        print('File does not exist')
except :
    print('An error occurred')  