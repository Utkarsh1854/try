function countDown(number) {

    console.log(number);

    let nextNumber = number - 1;

    if (nextNumber > 0) {

        countDown(nextNumber);

    }

}

countDown(5);
