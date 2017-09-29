// Objects:

const dany = {
  firstName: "Daenerys", // in javascript we use camel case as a convention to name everything.
  'last name': "Targaryen", // property names cannot have special characters or spaces unless decleared as a string.
  titles: [
    "Queen of Meereen",
    'Khaleesi of the Great Grass',
    'Queen of the Seven Kingdoms'
  ] // any type of valuye can be associated to a property in an object, including other objects, array, etc.
};

// All properties in objects are strings. No exception
dany.firstName // 'Daenerys'
Dany['last name'] //

// You can chain dots or backets to access object within objects with arrays, etc.
dany.titles.push()
dany.title.push('Queen of the Andals...')
Dany.title[3].repeat(2) // 'Queen of the Andals...Queen of the Andals...'
