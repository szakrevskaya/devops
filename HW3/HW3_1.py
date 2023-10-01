text = input("Enter the string with lower and upper case letters:")
upperLettersCount = sum(i.isupper() for i in text)
print(upperLettersCount)