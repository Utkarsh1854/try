// Create an array
const fruits = ["Apple", "Banana", "Mango", "Orange"];

console.log("Original Array:", fruits);

// i. Remove a specific element
let index = fruits.indexOf("Mango");

if (index !== -1) {
    fruits.splice(index, 1);
}

console.log("After Removing Mango:", fruits);

// ii. Check if array contains a value
let check = fruits.includes("Apple");

console.log("Apple Exists:", check);

// iii. Empty the array
fruits.length = 0;

console.log("After Emptying:", fruits);
