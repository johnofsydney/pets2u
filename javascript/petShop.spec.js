import { compute } from './petShop';

describe('PetShop', () => {
  test('one Rat', () => {
    expect(compute(['R'])).toEqual(['B1']);
  });

  test('one Hedgehog', () => {
    expect(compute(['H'])).toEqual(['B1']);
  });

  test('one Mongoose', () => {
    expect(compute(['M'])).toEqual(['B2']);
  });

  test('one Snake', () => {
    expect(compute(['S'])).toEqual(['B3']);
  });

  test('Rat, Hedgehog, Hedgehog', () => {
    expect(compute(['R', 'H', 'H'])).toEqual(['B3']);
  });

  test('Snake, Mongoose', () => {
    expect(compute(['S', 'M'])).toEqual(['B2', 'B3'].sort());
  });

  test('Snake, Hedgehog, Rat, Mongoose', () => {
    expect(compute(['S', 'H', 'R', 'M'])).toEqual(['B3', 'B3'].sort());
  });

  test('Rat, Hedgehog, Snake', () => {
    expect(compute(['R', 'H', 'S'])).toEqual(['B1', 'B3'].sort());
  });

  test('disallow other animals', () => {
    expect(() => compute(['F', ''])).toThrow(
      new Error('wrong animal!')
    );
  });
});
