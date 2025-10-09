const input = Deno.readTextFileSync("input.txt");

const [rawRules, rawUpdates] = input.split("\n\n");

const [rules, uniques] = (() => {
  const rs = rawRules
    .split("\n")
    .map((l) => l.split("|").map(Number) as [number, number]);

  const map = new Map<number, number[]>();
  const set = new Set<number>();

  for (const [l, r] of rs) {
    set.add(l);
    set.add(r);
    const rule = map.get(l);
    if (!rule) map.set(l, [r]);
    else rule.push(r);
  }
  
  return [map, set];
})();

const updates = rawUpdates.split("\n").map((u) => u.split(",").map(Number));

const ruleSizes = (() => {
  const out = [];
  for (const [, r] of rules) {
    out.push(r.length);
  }
  return out;
})();

console.log("Map:", rules);
console.log("Set:", uniques);
console.log("Map size:", rules.size);
console.log("Rule size:", ruleSizes);
