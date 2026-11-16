let base = Number(prompt("Enter triangle base:"));
let height = Number(prompt("Enter triangle height:"));

let length = Number(prompt("Enter rectangle length:"));
let breadth = Number(prompt("Enter rectangle breadth:"));

let radius = Number(prompt("Enter circle radius:"));

let triangle = 0.5 * base * height;
let rectangle = length * breadth;
let circle = Math.PI * radius * radius;

console.log("Area of Triangle = " + triangle);
console.log("Area of Rectangle = " + rectangle);
console.log("Area of Circle = " + circle);
