import { join } from '@std/path';

function createFileContents(day: number, part: number) {
  return `module Day${day}.Part${part} where

solution :: String -> String
solution input =
  input`;
}

function setupDay(day: number) {
  const base = join('src', `Day${day}`);

  Deno.mkdirSync(base);
  Deno.writeTextFileSync(join(base, 'Part1.hs'), createFileContents(day, 1));
  Deno.writeTextFileSync(join(base, 'Part2.hs'), createFileContents(day, 2));
  Deno.writeTextFileSync(join(base, 'test.txt'), '');
  Deno.writeTextFileSync(join(base, 'input.txt'), '');
}

for (let i = 2; i <= 25; i++) {
  setupDay(i);
}
