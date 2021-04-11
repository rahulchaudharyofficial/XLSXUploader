import { LightningElement, wire, track } from 'lwc';
import getAllSObjectType from '@salesforce/apex/GenericController.getAllSObjectType';

export default class AutoCompleteComponent extends LightningElement {
    @track sobjTypes;
    @track error;
    initialized = false;

    renderedCallback() {
        if(this.initialized)
            return;
        
        this.initialized = true;
        let listId = this.template.querySelector('datalist').id;
        this.template.querySelector("input").setAttribute("list", listId);
    }

    @wire (getAllSObjectType)
    wiredSObjTypes({error, data}) {
        if(data) {
            this.sobjTypes = data;
            this.initialized = true;
        let listId = this.template.querySelector('datalist').id;
        this.template.querySelector("input").setAttribute("list", listId);
        }
        else if(error) {
            this.sobjTypes = {};
            this.error = error;
        }
    }
}