const hello = {
  'Tester Board': {
    'To Do': ['Laundry', 'Buy Apples', 'Pay Phone Bill'],
    'Doing': ['Laundry', 'Studying Javascript', 'Studying HTML', 'Studying Ruby'],
    'Done': ['Laundry']
    },
    'Dreams': {
      'Wish List': ['Conquer the Seven Kingdoms', 'Get my baby back', 'My hand needs to chill'],
    }
};

// ***************** LIST BOARD *****************

function listBoards() {
  let counter = 1;
  let result = "";
  for (let key in hello) {
    result += `------------------\n`;
    result += `${counter} - ${key}\n`;
    counter += 1;
  }
  result += `------------------`;
  return result;
}

console.log( listBoards() );

// ***************** CREATE BOARD *****************

function createBoard (boardName) {

  if (hello[boardName]) {
    return `Board ${boardName} already exists`;
  } else {
    hello[boardName] = {};
    return `Board ${boardName} was created`;
  }
}

// ***************** REMOVE BOARD *****************

function removeBoard (boardName) {
  if (hello[boardName]) {
    delete hello[boardName];
    return `Board ${boardName} was removed`;
  } else {
    return `Board doesn't exist`;
  }
}

// ***************** DISPLAY BOARD *****************

function displayBoard (boardName) {
  let result = "";
  if (hello[boardName]) {
    for ( listName in hello[boardName] ) {
      result += `------------------\n`;
      result += `      ${listName}\n`
      result += `------------------\n`;
      for (taskList of hello[boardName][listName]) {
        result += ` > ${taskList}\n`;
      }
    }
    return result;
  } else {
    return `Board doesn't exist`;
  }
}

// ***************** CREATE LIST *****************

function createList (boardName, listName) {
  if (hello[boardName]) {
    if (hello[boardName][listName]) {
      return `${listName} already exists`;
    } else {
      hello[boardName][listName] = [];
    }
  } else {
    return `Board doesn't exists`;
  }
}

// ***************** CREATE CARD *****************

function createCard (boardName, listName, cardName) {
  if (hello[boardName]) {
    if (hello[boardName][listName]) {
      hello[boardName][listName].push(cardName)
    } else {
      return `List doesn't exists`;
    }
  } else {
  return `Board doesn't exists`;
  }
}

// ***************** REMOVE LIST *****************

// removeList: This should take a board name and a list name and removes the list from the board.

function removeList (boardName, listName) {
  if (hello[boardName]) {
    if (hello[boardName][listName]) {
      delete hello[boardName][listName];
      return `List ${listName} was removed`;
    } else {
      return `List doesn't exist`
    }
  } else {
    return `Board doesn't exist`;
  }
}

// ***************** REMOVE CARD *****************

// removeCard: This should take a board name, a list name and a card index and removes the card from the list of the provided board name.

function removeCard (boardName, listName, cardName) {
  if (hello[boardName]) {
    if (hello[boardName][listName]) {
      indexNumber = hello[boardName][listName].indexOf(cardName);
      if (hello[boardName][listName][indexNumber]) {
        delete hello[boardName][listName].splice(indexNumber, 1)
        return `Card ${cardName} was removed`;
      } else {
        return `Card doesn't exist`;
      }
    } else {
      return `List doesn't exist`
    }
  } else {
    return `Board doesn't exist`;
  }
}

// ***************** MOVE CARD *****************

// moveCard: This should take five argument, boardName, fromList, toList, fromCardIndex, toCardIndex. This should move a card with index fromCardIndex from the fromList to the toList. It should put it in the new list using the toCardIndex.

function moveCard (boardName, fromList, toList, fromCardIndex, toCardIndex) {
  if (hello[boardName]) {
    if (hello[boardName][fromList]) {
      if (hello[boardName][fromList][fromCardIndex]) {
        let transferCard = hello[boardName][fromList][fromCardIndex]
        hello[boardName][toList][toCardIndex] = transferCard
        // hello[boardName][toList][toCardIndex].push(transferCard) # Use if fromCardIndex length is not known
        delete hello[boardName][fromList].splice(fromCardIndex, 1)
        return `Card ${transferCard} was move to ${toList}`;
      } else {
        return `Card doesn't exist`;
      }
    } else {
      return `List doesn't exist`
    }
  } else {
    return `Board doesn't exist`;
  }
}
//
// console.log( createBoard ("Tim") );
// console.log( createBoard ("Rob") );
// console.log( createBoard ("Rob") );
// console.log( listBoards () );
// console.log( removeBoard ('Tim') );
// console.log( displayBoard ('Tester Board') );
// console.log( createList ('Dreams', 'Wish List') );
// createList ('Dreams', 'Future Trips');
// createCard ('Dreams', 'Future Trips', 'Iceland')
// createCard ('Dreams', 'Future Trips', 'Slovakia')
// createCard ('Dreams', 'Future Trips', 'Sweden')
// createList ('Rob', 'Filler');
// createList ('Rob', 'Delete-Me');
// console.log( removeList ('Rob', 'Delete-Me') );
// console.log(removeCard ('Dreams', 'Future Trips', 'Slovakia'))
// console.log(removeCard ('Dreams', 'Future Trips', 'Bob'))
// console.log(hello['Dreams']['Future Trips'][0]);
// console.log(moveCard ('Dreams', 'Future Trips', 'Wish List', 0, 0))
// console.log(hello);
