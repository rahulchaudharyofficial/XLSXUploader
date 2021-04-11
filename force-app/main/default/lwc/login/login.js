import { LightningElement, track } from 'lwc';
/* eslint-disable no-console */
 /* eslint-disable no-alert */
export default class Login extends LightningElement {
    @track inputText="";

    constructor() {
        super();
        console.log('Component Created');
    }

    connectedCallback() {
        console.log('Connected Callback Created');
    }

    disconnectedCallback() {
        console.log('Disconnected Callback Created');
    }
    
    changeHandler(event) {
        this.inputText = event.target.value;
        alert("Alerted");
    }

    renderedCallback() {
        console.log("Hello world");   
        console.log(this.inputText);
        //this.inputText="initializing";
    }

    contacts = [
        {
            Id: '003171931112854375',
            Name: 'Amy Taylor',
            Title: 'COO',
        },
        {
            Id: '003192301009134555',
            Name: 'Michael Jones',
            Title: 'CTO',
        },
        {
            Id: '003848991274589432',
            Name: 'Jennifer Wu',
            Title: 'CEO',
        },
    ];
    
}