export const compute = (animals) => {
  if (animals.join('').match(/[^SMRH]/)) {
    throw new Error ('wrong animal!')
  }

  let requiredBoxes = [];

  // the sapce that the animals will take up
  let requiredArea = animals.reduce( (area, animal) => {
    let animalArea = ANIMAL_INFO[animal].area
    return area + animalArea
  },0)

  // for now, preserve original calculation
  let unallocatedArea = requiredArea;
  console.log(`unallocatedArea ${unallocatedArea}`)

  while (unallocatedArea > 0) {
    if (unallocatedArea > 800) {
      requiredBoxes.push('B3')
      unallocatedArea = unallocatedArea - 1600
    }
    else if (unallocatedArea >= 800) {
      requiredBoxes.push('B2')
      unallocatedArea = unallocatedArea - 800
    }
    else if (unallocatedArea = 400) {
      requiredBoxes.push('B1')
      unallocatedArea = unallocatedArea - 400
    }
  }

  return(requiredBoxes.sort());
};



const ANIMAL_INFO = {
  R: {
    name: "Rat",
    area: 400
  },
  H: {
    name: "Hedgehog",
    area: 400
  },
  M: {
    name: "Mongoose",
    area: 800
  },
  S: {
    name: "Snake",
    area: 1200
  }
}

const BOX_INFO = {
  B1: {
    area: 400
  },
  B2: {
    area: 800
  },
  B3: {
    area: 1600
  }
}