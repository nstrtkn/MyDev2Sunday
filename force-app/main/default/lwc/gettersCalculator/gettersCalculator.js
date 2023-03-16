import { LightningElement } from 'lwc';

export default class GettersCalculator extends LightningElement {

    firstNum = 0;
    secondNum = 0;

    total;

    changeHandler1(event) {
        this.firstNum = event.target.value;
        this.total = Number(this.firstNum) + Number(this.secondNum);
    }

    changeHandler2(event) {
        this.secondNum = event.target.value;
        this.total = Number(this.firstNum) + Number(this.secondNum);
    }
}

// import { LightningElement } from 'lwc';

// export default class Calculator extends LightningElement {
//     num1;
//     num2;
//     total;

//     changeHandler(event) {
//         if(event.target.name === "Number 1") {
//             this.num1 = event.target.value;
//         } else {
//             this.num2 = event.target.value;
//         }
//         if(this.num1 == undefined) {
//             this.num1 = 0;
//         }
//         if(this.num2 == undefined) {
//             this.num2 = 0;
//         }

//         this.total = Number(this.num1) + Number(this.num2);
//     }
// }