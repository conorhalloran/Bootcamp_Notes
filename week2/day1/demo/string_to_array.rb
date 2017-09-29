Find out how to convert a string sentence to an array of words:
str.each_line(separator).to_a.

sentence = "This is a test of coverting strings"
sentence.split ["This", "is", "a", "test", "of", "converting", "strings"]
sentence.split.count = 7

How to convert an array of words to a sentence:
sentence = ["Hello", "CodeCore", "Students"]
sentence.join(' ') = 'Hello CodeCore Students
sentence.join(',') = Hello,CodeCore,Students
