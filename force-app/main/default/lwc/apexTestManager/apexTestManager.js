import { LightningElement, wire } from 'lwc';
import GETAPEXTEST from '@salesforce/apex/ApexClassManager.getApexTestConfiguration';

export default class ApexTestManager extends LightningElement {
    @wire(GETAPEXTEST)
    getApexTest({data,error}) {
        if(data) {
            console.log('Data => '+JSON.stringify(data));
        }
        else if(error) {

        }
    }
}