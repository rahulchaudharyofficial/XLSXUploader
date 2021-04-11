/* eslint-disable no-console */
import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/ContactController.getContactList';
export default class Demo1 extends LightningElement {
    @wire(getContactList) contacts;

    connectedCallback() {
        console.log("contacts => "+JSON.stringify(this.contacts));
    }
}