// Write a function, parseCSV, to parse a string formatted as CSV into an array of objects as shown below:

// Note that the following string is created with back ticks. This is important because it allows use to a create a string on multiple lines.
// let csvData = `
// id,first name,last name,email
// 1,jane,doe,wildmirror@yahoo.com
// 2,john,doe,tamepool@hotmail.com
// 3,sherlock,holmes,mag@glass.com
// 4,natalia,romanov,8legged@ninja.com
// 5,peter,quill,starlord@gmail.com
// `

/* ******************

const csvData = `
id,firstName,lastName,email
1,jane,doe,wildmirror@yahoo.com
2,john,doe,tamepool@hotmail.com
3,sherlock,holmes,mag@glass.com
4,natalia,romanov,8legged@ninja.com
5,peter,quill,starlord@gmail.com
`;

// console.log(csvData);

function parseCSV(csvString) {

  const csvArray = csvString.trim().replace(/\n/g,",").split(",");
  // console.log(csvArray);
  let csvArrayOfObj = [];
  let csvObject = {};
  for (let i = 4; i<csvArray.length; i++) {
    const key = csvArray[i % 4];

    if (key === "firstName" || key === "lastName") {
      csvObject[key] = csvArray[i][0].toUpperCase() + csvArray[i].slice(1);
    } else {
      csvObject[key] = csvArray[i];
    }

    if (Object.keys(csvObject).length === 4) {
      csvArrayOfObj.push(csvObject);
      csvObject = {};
    }
  }
  return csvArrayOfObj;
}

const users = parseCSV(csvData);
console.log(users);


function search(arrayOfObj, string) {
  for (let object of arrayOfObj) {
    if (object.firstName.toLowerCase() === string.toLowerCase() || object.lastName.toLowerCase() === string.toLowerCase()) {
      console.log(object);
    }
  }
}

search(users, 'romanov');
search(users, 'peter');



 ****************** */


const csv = `
id,first name,last name,email
1,jane,doe,wildmirror@yahoo.com
2,john,doe,tamepool@hotmail.com
3,sherlock,holmes,mag@glass.com
4,natalia,romanov,8legged@ninja.com
5,peter,quill,starlord@gmail.com
`

let headers = csv[1].split(',');
let dataArray = [];

for (i=2; i<csv.length; i++) {
  let data = csv[i].split(',');
  if (data.length == headers.length) {
    let lines = [];
    for ( j=0; j<headers.length; j++) {
      lines.push(headers[j]+":"+data[j]);

    }

    dataArray.push(lines);

  }

}


console.log(dataArray)
console.log(headers);
