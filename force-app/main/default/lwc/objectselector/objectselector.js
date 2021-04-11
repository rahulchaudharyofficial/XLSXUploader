import { LightningElement, wire, track } from 'lwc';
import getSchemaObjects from '@salesforce/apex/ObjectSelector.getSchemaObjects';

export default class Objectselector extends LightningElement {

    @track options;
    @track value;
    placeholder = '-- None --';

    @wire (getSchemaObjects)
    wiredoptions({error, data}) {
        if(data) {
            this.options = data;
            this.initialized = true;
        
        }
        else if(error) {
            this.options = {};
            this.error = error;
        }
    }   

    handleChange(event) {
        this.value = event.target.value;
        console.log('data => '+ JSON.stringify(this.options));
    }
}