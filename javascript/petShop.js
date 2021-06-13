export const compute = (animals) => {
  if (animals.join('').match(/[^SMRH]/)) {
    throw new Error ('wrong animal!')
  }

  const requiredBoxes = [];

  // transform array to object with quantities
  animals = transform(animals)

  // consolidate animals
  animals = consolidate(animals)

  // calculates Boxes for snakes and companions
  for (let index = 0; index < animals.snakes.quantity; index++) {
    requiredBoxes.push('B3')
  }

  // remaining boxes depends on how much area we have to fill
  let unallocatedArea = (
    (animals.smallAnimals.area) + (animals.mongeese.area)
    )
    while (unallocatedArea > 0) {
    if (unallocatedArea > BOX_SIZES.B2) {
      requiredBoxes.push('B3')
      unallocatedArea = unallocatedArea - BOX_SIZES.B3
    }
    else if (unallocatedArea >= BOX_SIZES.B2) {
      requiredBoxes.push('B2')
      unallocatedArea = unallocatedArea - BOX_SIZES.B2
    }
    else if (unallocatedArea = BOX_SIZES.B1) {
      requiredBoxes.push('B1')
      unallocatedArea = unallocatedArea - BOX_SIZES.B1
    }
  }

  return(requiredBoxes.sort())
};

// input an array of leters representing animals
// return: an object with
//    keys: all possible animal letters,
//    values: the quantities of each animal in the input
const transform = (sentence) => {
  // adapted from my solution to word-count exercise:
  // https://github.com/johnofsydney/exercisms/tree/master/javascript/word-count
  return (
    sentence.reduce( (result, word) => {
        result[word] ? result[word]++ : result[word] = 1
        return(result)
      }, {S: 0, M: 0, R: 0, H: 0})
  );
};

// input: object representing quantities of each animal
// output: object with actual quantites of snakes and mongeese
// and the combined total of small animals that remain after allocating one
// small animal per snake
const consolidate = (animals) => {
  let snakes = animals['S'];
  let mongeese = animals['M'];
  let smallAnimals = animals['H']+ animals['R'];

  // we can squeeze a small animal in with each snake
  let remainingSmallAnimals = smallAnimals > snakes ? smallAnimals - snakes : 0;

  return(
    {
      snakes: {
        quantity: snakes, area: snakes * 1200
      },
      mongeese: {
        quantity: mongeese, area: mongeese * 800
      },
      smallAnimals: {
        quantity: remainingSmallAnimals, area: remainingSmallAnimals * 400
      }
    }
  )
}

const BOX_SIZES = {
  B1: 400,
  B2: 800,
  B3: 1600
}
