

---
# regex

"""
. - any character except a new line
* - 0 or more repetitions
+ - 1 or more repetitions
? - 0 or 1 repetition
{m} - m repetitions
{m,n} - m-n repetitions
\ - escape character
r - use raw string in python
^ - matches the start of the string
$ - matches at the end of the string
[] - set of characters
[^] - cannot match set of characters
\w - any word character [a-zA-Z0-9_]
\W - not a word character
\s - whitespace characters
\S - not a whitespace character
\d - decimal digit
\D - not a decimal digit

"""


---
# write to files

name = input("What is your name? ")


with open("names.txt", "a") as file:
    file.write(f"{name}\n")

# read from file
    
with open("names.txt") as file:
    for line in file:
        names.append(line.rstrip())

for name in sorted(names):
    print(f"hello, {name}")


## working with CSVs
    

students = []

with open("students.csv") as file:
    for line in file:
        name, house = line.rstrip().split(",") # split at comma 
        student = {"name": name, "house": house}
        students.append(student)


# using anonymous lambda function here, access the dictionary and get the name value
for student in sorted(students, key=lambda student: student["name"]):
    print(f"{student['name']} is in {student['house']}")

### contents of students.csv
"""
name,home
Harry,Privet dr
Ron,The Burrow
Draco,Malfoy Manor
"""
import csv

students = []

with open("students.csv") as file:
    # retrieves file as dict object
    reader = csv.DictReader(file)
    for row in reader:
        students.append({"name": row["name"], "home": row["home"]})

for student in sorted(students, key=lambda student: student["name"]):
    print(f"{student['name']} is in {student['house']}")


# Writing to CSV
    
import csv 

name = input("What is your name? ")
home = input("What is your home? ")

with open("students.csv", "a") as file:
    writer = csv.writer(file)
    writer.writerow([name,home])



# Using Dict
    
import csv 

name = input("What is your name? ")
home = input("What is your home? ")

with open("students.csv", "a") as file:
    writer = csv.DictWriter(file, fieldnames=["name", "home"]) # pass expected fieldnamed
    writer.writerow({"name": name, "home": home})


# Creating a gif
    
# usage: ./script.py image.png image2.png
    
import sys

from PIL import Image 

# Create list to store static images
images = []

#loop over command line arguments after script name
for arg in sys.argv[1:]:
    image = Image.open(arg) # open image
    images.append(image) # append to images list

# save image and loop infinitely
images[0].save(
    "costumes.gif", save_all=True, append_images=[images[1]], duration=200, loop=0
)

---


# For pytest, create folder test, and create file: __init__.py (treat folder as a package)

# calculator.py

def main():
    x = int(input("What is x? "))
    print("x squared is", square(x))

def square(n):
    return n * n


# test_calculator.py

from calculator import square
import pytest

# def main():
#     test_square()

def test_positive():
    assert square(2) == 4
    assert square(3) == 9

def test_negative():
    assert square(-2) == 4
    assert square(-3) == 9

def test_positive():
    assert square(0) == 0

def test_str():
    with pytest.raises(TypeError):
        square("cat")



if __name__ == "__main__":
    main()


# hello.py

def main():
    name = input("What is your name? ")
    print(hello(name))

def hello(to="world"):
    return f"hello, {to}"


if __name__ == "__main__":
    main()


# test_hello.py
    
from hello import hello

def test_default():
    assert hello() == "hello, world"

def test_argument():
    assert hello("David") == "hello, David"

if __name__ == "__main__":
    main()

---

### Libraries

import sys
import json
import requests

# try:
#     print("Hello, my is" sys.argv[1])
# except IndexError:
#     print("Too few arguments")

# if len(sys.argv) < 2:
#     sys.exit("Too few arguments")
# elif len(sys.argv) > 2:
#     sys.exit("Too many arguments")

# print("Hello, my is", sys.argv[1])

# if len(sys.argv) < 2:
#     sys.exit("Too few arguments")

# for arg in sys.argv[1:]:
#     print("Hello, my name is", arg)

if len(sys.argv) != 2:
    sys.exit()

response = requests.get("https://itunes.apple.com/search?entity=song&limit=50&term" + sys.argv[1])
#print(json.dumps(response.json(), indent=2)

o = response.json()
for result in o["results"]:
    print(result["trackName"])

---

# Exceptions

def main():
    x = get_int("What's x? ")
    print(f"x is {x}")

def get_int(prompt):
    while True:
        try:
            return int(input(prompt))
        except ValueError:
            print ("x is not an integer")
            # pass can also be used to not return any errors

if __name__ == "__main__":
    main()

---


