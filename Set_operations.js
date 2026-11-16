function subset(setA, setB) {
    for (let i of setB) {
        if (!setA.has(i)) {
            return false;
        }
    }
    return true;
}

function difference(setA, setB) {
    let differenceSet = new Set(setA);
    for (let i of setB) {
        differenceSet.delete(i);
    }
    return differenceSet;
}

function intersection(setA, setB) {
    let intersectionSet = new Set();
    for (let i of setB) {
        if (setA.has(i)) {
            intersectionSet.add(i);
        }
    }
    return intersectionSet;
}

function union(setA, setB) {
    let unionSet = new Set(setA);
    for (let i of setB) {
        unionSet.add(i);
    }
    return unionSet;
}

const setA = new Set(["apple", "mango", "orange"]);
const setB = new Set(["grapes", "apple", "banana"]);
const setC = new Set(["apple", "orange"]);

console.log("Subset (C in A):", subset(setA, setC));
console.log("Difference (A - B):", difference(setA, setB));
console.log("Intersection (A ∩ B):", intersection(setA, setB));
console.log("Union (A ∪ B):", union(setA, setB));
