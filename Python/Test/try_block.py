import os

try:
    if os.path.exists('test.txt'):
        print('File exists')
    else:
        print('File does not exist')
except Exception as e:
    print(f'The error {e} occurred')
