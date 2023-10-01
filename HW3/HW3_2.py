import os

hostname = "google.com"
response = os.system("ping " + hostname)

if response == 0:
  print("Success")
else:
  print("Doesn't work")