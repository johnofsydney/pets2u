export const compute = (animals) => {
  if (animals.join('').match(/[^SMRH]/)) {
    throw new Error ('wrong animal!')
  }

  const requiredBoxes = [];

  // how many snake boxes
  const snakeBoxes = animals.reduce( (count, animal) => {
    let a = (animal == 'S') ? 1 : 0;
    return (count + a)
  }, 0)

  // how many small animals
  let smallAnimals = animals.reduce( (count, animal) => {
    let a = (animal == 'R' || animal == 'H') ? 1 : 0;
    return (count + a)
  }, 0)

  // if there are small animals, squeeze them into the snake boxes
  // store the number of remaining small animals
  smallAnimals = smallAnimals > snakeBoxes ? smallAnimals - snakeBoxes : 0;

  // calculates Boxes for snakes and companions
  for (let index = 0; index < snakeBoxes; index++) {
    requiredBoxes.push('B3')
  }

  // how many medium animals
  let mediumAnimals = animals.reduce( (count, animal) => {
    let a = (animal == 'M') ? 1 : 0;
    return (count + a)
  }, 0)


  // 3 - depends on how many animals we have
  let unallocatedArea = (smallAnimals * 400) + (mediumAnimals * 800)
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
