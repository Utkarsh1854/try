<!DOCTYPE html>
<html>
<head>
    <title>Area of Shapes</title>
</head>
<body>

<h2>Area Calculator</h2>

<script>
    let base = Number(prompt("Enter triangle base:"));
    let height = Number(prompt("Enter triangle height:"));

    let length = Number(prompt("Enter rectangle length:"));
    let breadth = Number(prompt("Enter rectangle breadth:"));

    let radius = Number(prompt("Enter circle radius:"));

    let triangle = 0.5 * base * height;
    let rectangle = length * breadth;
    let circle = Math.PI * radius * radius;

    document.write("Area of Triangle = " + triangle + "<br>");
    document.write("Area of Rectangle = " + rectangle + "<br>");
    document.write("Area of Circle = " + circle.toFixed(2));
</script>

</body>
</html>
