function count<T>(xs: IterableIterator<T>) {
  let i = 0;
  for (const _ of xs) {
    i++;
  }
  return i;
}

function crosswords(lineLength: number, input: string) {
  const patterns = [
    /(?=XMAS)/g,
    /(?=SAMX)/g,
    new RegExp(`(?=X.{${lineLength - 1}}M.{${lineLength - 1}}A.{${lineLength - 1}}S)`, 'g'),
    new RegExp(`(?=S.{${lineLength - 1}}A.{${lineLength - 1}}M.{${lineLength - 1}}X)`, 'g'),
    new RegExp(`(?=X.{${lineLength}}M.{${lineLength}}A.{${lineLength}}S)`, 'g'),
    new RegExp(`(?=X.{${lineLength}}M.{${lineLength}}A.{${lineLength}}S)`, 'g'),
    new RegExp(`(?=S.{${lineLength - 2}}A.{${lineLength - 2}}M.{${lineLength - 2}}X)`, 'g'),
    new RegExp(`(?=S.{${lineLength - 2}}A.{${lineLength - 2}}M.{${lineLength - 2}}X)`, 'g')
  ];

  return patterns.reduce((acc, pattern) => acc + count(input.matchAll(pattern)), 0);
}

const contents: string = Deno.readTextFileSync('input.txt');
const lines = contents.split('\r\n');
const input = lines.join('');
const result = crosswords(lines[0].length, input);
console.log(result);
